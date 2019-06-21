#!/bin/bash

user=$(who)

#MENU="$(rofi -sep '|' -dmenu -i -p 'System' -hide-scrollbar echo -e " Lock| Logout| Reboot")"
MENU="$(echo "	Lock|	Logout|	Suspend|	Reboot|	Shutdown" | rofi -sep '|' -dmenu -i -p "System: ")"


case "$MENU" in
	*Lock) sh ~/dotfiles/scripts/lock.sh ;;
        *Logout) bspc quit && umount /home/tobias/Nextcloud && pkill -KILL -u $user ;;
	*Suspend) systemctl suspend ;;
        *Reboot) systemctl reboot ;;
        *Shutdown) systemctl -i poweroff ;;
esac
