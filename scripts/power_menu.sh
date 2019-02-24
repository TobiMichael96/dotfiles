#!/bin/bash

#MENU="$(rofi -sep '|' -dmenu -i -p 'System' -hide-scrollbar echo -e " Lock| Logout| Reboot")"
MENU="$(echo " Lock| Logout| Reboot| Shutdown" | rofi -sep '|' -dmenu -i -p "System: ")"


case "$MENU" in
	*Lock) sh ~/.config/scripts/physlock.sh ;;
        *Logout) bspc quit && exit ;;
        *Reboot) systemctl reboot ;;
        *Shutdown) systemctl -i poweroff ;;
esac
