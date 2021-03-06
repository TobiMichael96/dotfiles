# simple script to backup and restore (dot)files
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

## checking for input
read -p "Do you want to [b]ackup or [r]estore the files? " option

## install yay and pacman packages
install_everything() {
	if pacman -Qs yay > /dev/null; then
		echo "Yay already installed, skipping..."
	else
		cd /tmp
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si
		echo "Yay installed..."
	fi

	sudo pacman -S --needed - < ~/.config/pacman_list.txt
	yay -S --needed - < ~/.config/aur_list.txt

	echo ""
	echo "Everything is installed now..."
	echo "Enjoy..."
}


## restoring files
restore_files() {
	if [ ! -f ~/dotfiles/submodule.txt ]; then
		echo "Available submodules:"
		cat ~/dotfiles/.gitmodules | grep "path =" | awk '{print $3}'
		echo ""
		read -p "What dotfiles do you want to use? [] " option
		echo $option > ~/dotfiles/submodule.txt
	else
		option=$(cat ~/dotfiles/submodule.txt)
	fi

	if [ ! -d ~/.config ]; then
        	ln -s $DIR/$option ~/.config
	fi

	if [[ ! -d ~/.screenlayout && -d ~/.config/screenlayout ]]; then
        	ln -s $DIR/$option/screenlayout ~/.screenlayout
	fi

	for fn in $(ls -ap $DIR/$option | grep -v / | grep -v ".git" | grep -v "README.md" | grep -v ".txt"); do
		if [ ! -f ~/$fn ]; then
			ln -s $DIR/$option/$fn ~/$fn
		fi
	done

	cd ~/.config
	git checkout master

	echo ""
	echo "Restoring completed..."

	read -p "Do you want everything to be installed for you? [y/n] " option

	if [[ $option == "y" ]]; then
        	echo "Beginning to install now..."
        	install_everything
	else
        	echo "Ok. Exiting now..."
	fi
}


## backing files up
backup_files() {
	pacman -Qqen | awk '{print $1}' > ~/.config/pacman_list.txt
	pacman -Qqem | awk '{print $1}' > ~/.config/aur_list.txt

	cd ~/dotfiles
	git pull >/dev/null
	git submodule update --recursive --remote

	cd ~/.config
	echo ""
	echo "Updating submodule now..."
	for fn in $(git ls-tree -d -r --name-only @); do
                git add $fn
        done
	git add -u

        git update-index -q --refresh
        CHANGED=$(git status | grep "nothing to" )
	if [ ! "$CHANGED" ]; then
                git commit -m "Automatic update in submodule at $(date +"%c")."
                git push origin HEAD:master
	else
		echo "No changes in submodule to push to repository..."
        fi

	cd ~/dotfiles
	echo ""
	echo "Updating dotfiles now..."
	git add -u
	git add $(cat submodule.txt)

	git update-index -q --refresh
	CHANGED=$(git status | grep "nothing to" )
	if [ ! "$CHANGED" ]; then
		echo "Pushing changes now..."
		git commit -m "Automatic update at $(date +"%c")."
		git push
	else
		echo "No changes to push to repository..."
	fi

	git pull >/dev/null
        git submodule update --recursive --remote

	echo ""
	echo "Backup finished..."
}

## checking for options
if [[ $option == "r" ]]; then
	echo "Restoring files now..."
	restore_files
elif [[ $option == "b" ]]; then
	echo "Backing up files now..."
	backup_files
else
	echo "Invalid option. Exiting now..."
	exit
fi
