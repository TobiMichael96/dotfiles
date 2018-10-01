#!/usr/bin/env bash

datetime=$(date "+%a, %d %b — %H:%M")
battery=$(~/.config/scripts/battery.sh g)
brightness=$(~/.config/scripts/brightness.sh)
volume=$(~/.config/scripts/volume.sh)
wifi=$(~/.config/scripts/wifi.sh)
#email=$(python ~/.config/scripts/email.py)
#workspace=$(~/.config/scripts/workspace.sh)
#temp=$(~/.config/scripts/temp.sh)

notify-send "Information" "$datetime \n$battery \n$brightness \n$volume \n$wifi"
