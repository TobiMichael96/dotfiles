# simple script to backup and restore (dot)files
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

## checking for input
read -p "Do you want to [b]ackup or [r]estore the files? " option

## restoring files
restore_files() {
	read -p "What dotfiles do you want to use? [laptop/desktop/work] " option
	
	echo $option > submodule.txt

	if [ ! -d ~/.config ]; then
        	ln -s $DIR/$option ~/.config
	fi	

	for fn in $(ls -ap $DIR/$option | grep -v / | grep -v ".git" | grep -v "README.md" | grep -v ".txt"); do
		ln -s $DIR/$option/$fn ~/$fn
	done

	echo ""
	echo "Restoring completed..."
}


## backing files up
backup_files() {
	pacman -Qqe | awk '{print $1}' > ~/.config/pacman_list.txt
	pacman -Qqem | awk '{print $1}' > ~/.config/aur_list.txt

	cd ~/.config
	for fn in $(git ls-tree -d -r --name-only @); do
                git add $fn
        done
	git add -u

	cd ~/dotfiles
	git add -u
	git add $(cat submodule.txt)

	git update-index -q --refresh
	CHANGED=$(git diff-index --name-only HEAD --)

	if [ -n "$CHANGED" ]; then
		echo "Pushing changes now..."
		git commit -m "Automatic update at $(date +"%c")."
		git push
		echo ""
		echo "Backup finished..."
	else
		echo "No changes to push to repository..."
	fi
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
