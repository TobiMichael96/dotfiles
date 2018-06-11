#!/usr/bin/env bash

datetime=$(date "+%a, %d %b — %H:%M")
battery=$(~/.config/scripts/battery.sh g)
brightness=$(~/.config/scripts/brightness.sh)
volume=$(~/.config/scripts/volume.sh)
wifi=$(~/.config/scripts/wifi.sh)
email=$(python ~/.config/scripts/email.py)
uptime=$(uptime | awk '{print $3, $4, $5}' | sed 's/,$//')

notify-send "Information" "$datetime \nUptime $uptime \n$battery \n$brightness \n$volume \n$wifi \n$email"
