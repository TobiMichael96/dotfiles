#!/bin/bash

user=$(who)

#MENU="$(rofi -theme window -sep '|' -dmenu -i -p 'System' -hide-scrollbar echo -e " Lock| Logout| Reboot")"
MENU="$(echo "	Lock|	Logout|	Suspend|	Reboot|	Shutdown" | rofi -theme window -sep '|' -dmenu -i -p "System: ")"


case "$MENU" in
	*Lock) sh ~/dotfiles/scripts/lock.sh ;;
        *Logout) bspc quit && umount /home/tobias/Nextcloud && pkill -KILL -u $user ;;
	*Suspend) if [ -f "/home/tobias/dotfiles/mqtt-client/server.txt" ]; then python /home/tobias/dotfiles/mqtt-client/mqtt-status.py off; fi && systemctl suspend ;;
        *Reboot) systemctl reboot ;;
        *Shutdown) systemctl -i poweroff ;;
esac
