#!/usr/bin/env bash
if [[ $1 -eq "1" ]]; then
  sleep 3
  sh ~/.screenlayout/withoutTV.sh
  bspc monitor LVDS1 -d 1 2 3 4 5 6 7 8
  bspc monitor HDMI1 -d 9 10
  sh ~/.config/polybar/launch.sh &
  sh ~/.config/scripts/physlock.sh &
  sh ~/.config/scripts/battery.sh &
  sh ~/.config/scripts/polybar_toggle.sh &
  # other programms to autostart
  sleep 5
  keepassxc &
else
  connected=$(xrandr -q | grep " connected" | cut -d ' ' -f1 | sed -n 2p)
  if [ ! -z "$connected" ]; then
    sh ~/.screenlayout/withTV.sh
    sleep 1
    bspc monitor LVDS1 -d 1 2 3 4 5 6 7 8
    bspc monitor HDMI1 -d 9 10
    notify-send "Screen" "Second screen added..."
  else
    sh ~/.screenlayout/withoutTV.sh
    sleep 1
    bspc monitor LVDS1 -d 1 2 3 4 5 6 7 8
    bspc monitor HDMI1 -d 9 10
    notify-send "Screen" "Second screen removed..."
  fi
    sh ~/.config/scripts/hdmi_sound_toggle.sh
fi
