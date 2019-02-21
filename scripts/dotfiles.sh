# simple script to backup and restore (dot)files


## check if .config exists, if not create it
if [ ! -d ~/.config ]; then
	echo ".config does not exist, creating now..."
	mkdir ~/.config
fi

## entering .config
cd ~/.config


## declaring files
declare -a files 
files=( "~/.Xresources" "~/.xinitrc" "~/.zprofile" "~/.zshrc" "~/.bash_profile" "~/.bashrc" "~/.config/aur_list.txt" "~/.config/pacman_list.txt" ) 

## declaring folders
declare -a folders
folders=( "bspwm" "background" "dunst" "compton" "polybar" "rofi" "scripts" "sxhkd" )

## checking for input
read -p "Do you want to [b]ackup or [r]estore the files? " option

## restoring files
restore_files() {
	if [ ! -d .git ]; then
        	echo "Git repository does not exist, cloning now..."
	        git clone git@gitlab.com:tobimichael/dotfiles.git
	fi
	
	echo $(git branch -a)
	read -p "What branch do you want to use? " option_branch

	git checkout $option_branch


	for fn in ${files[@]}; do
                echo $fn
                rsync -r -u ~/.config/$fn ~/$fn
        done
}


## backing files up
backup_files() {
        for fn in ${files[@]}; do
                rsync -r -u ~/$fn ~/.config/$fn
		git add $fn
        done

	for fn in ${folders[@]}; do
                git add $fn
        done
	
	git add -u

	git update-index -q --refresh
	CHANGED=$(git diff-index --name-only HEAD --)

	if [ -n "$CHANGED" ]; then
		git commit -m "Automatic update at $(date +"%c")."
		git push
	fi
}

## checking for options
if [[ $option == "r" ]]; then
	echo "Restoring files now..."
elif [[ $option == "b" ]]; then
	echo "Backing up files now..."
	backup_files
else
	echo "Invalid option. Exiting now..."
	exit
fi
