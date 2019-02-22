# All my dotfiles

## What is this?

From this point you can clone the repository, run the script and restore all my dotfiles.

## How?

1. `git clone --recursive https://gitlab.com/tobimichael/dotfiles.git` 
2. `cd dotfiles`
3. `./dotfiles.sh`
4. `Follow the instructions in the terminal.`

## What now?

You are probably missing most of the packages needed for the setup so you have to run `sudo pacman -S --needed - < ~/.config/pacman_list.txt` to install these packages.

I recommend to install [trizen](https://github.com/trizen/trizen) too:
1. `git clone https://aur.archlinux.org/trizen.git`
2. `cd trizen`
3. `makepkg -si`

After that you can install all AUR packages. Just run `trizen -S - < ~/.config/aur_list.txt` to install those.

Now you are ready to feel the power that comes with a Unix system.

## Why?

Because.
