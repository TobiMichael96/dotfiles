#!/bin/bash

user=$(who)

#MENU="$(rofi -sep '|' -dmenu -i -p 'System' -hide-scrollbar echo -e " Lock| Logout| Reboot")"
MENU="$(echo " Lock| Logout| Reboot| Shutdown" | rofi -sep '|' -dmenu -i -p "System: ")"


case "$MENU" in
	*Lock) sh ~/.config/scripts/physlock.sh ;;
        *Logout) bspc quit && umount /home/tobias/Nextcloud && pkill -KILL -u $user ;;
        *Reboot) systemctl reboot ;;
        *Shutdown) systemctl -i poweroff ;;
esac
