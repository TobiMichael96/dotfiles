# simple script to backup and restore (dot)files
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

## checking for input
read -p "Do you want to [b]ackup or [r]estore the files? " option

## restoring files
restore_files() {
	read -p "What dotfiles do you want to use? [laptop/desktop/work] " option

	echo $option > $DIR/submodule
	
        ln -s $DIR/$option $DIR/.config
}


## backing files up
backup_files() {
	pacman -Qqe | awk '{print $1}' > ~/.config/pacman_list.txt
	pacman -Qqem | awk '{print $1}' > ~/.config/aur_list.txt

        for fn in ${files[@]}; do
                rsync -r -u ~/$fn ~/.config/$fn
		git add $fn
        done

	for fn in $(git ls-tree -d -r --name-only @); do
                git add $fn
        done
	
	git add -u

	git update-index -q --refresh
	CHANGED=$(git diff-index --name-only HEAD --)

	if [ -n "$CHANGED" ]; then
		echo "Pushing changes now..."
		git commit -m "Automatic update at $(date +"%c")."
		git push
		echo ""
		echo ""
		echo "Backup finished..."
	else
		echo "No changes to push to repository..."
	fi
}

## checking for options
if [[ $option == "r" ]]; then
	echo "Restoring files now..."
	sleep 3
	restore_files
elif [[ $option == "b" ]]; then
	echo "Backing up files now..."
	sleep 3
	backup_files
else
	echo "Invalid option. Exiting now..."
	exit
fi
