#!/usr/bin/env bash
used=$(xrandr -q | grep "HDMI-A-0")
used=${used:19:4}

if [ $1 -eq "1" ]; then
  sleep 2
  sh ~/.screenlayout/withoutTV.sh
  bspc monitor HDMI-A-1 -d 1 2 3 4 5 6
  bspc monitor DVI-D-0 -d 7 8 9 10
  feh --bg-fill --no-xinerama --randomize ~/.config/background/*
  sh ~/.config/scripts/pywal.sh &
  sh ~/.config/polybar/launch.sh &

  # other programms to autostart
  sleep 5
  keepassxc &

else
  if ! [[ $used =~ ^[0-9]+$ ]]; then
    sh ~/.screenlayout/withTV.sh
    sleep 1
    feh --bg-fill --randomize ~/.config/background/*
    sh ~/.config/scripts/pywal.sh
    bspc monitor HDMI-A-1 -d 1 2 3 4 5 6
    bspc monitor DVI-D-0 -d 7 8 9 10
    bspc monitor HDMI-A-0 -d 11
    sh ~/.config/polybar/launch.sh
    notify-send "Screen" "Second screen added..."
  else
    sh ~/.screenlayout/withoutTV.sh
    sleep 1
    feh --bg-fill --randomize ~/.config/background/*
    sh ~/.config/scripts/pywal.sh
    bspc monitor HDMI-A-1 -d 1 2 3 4 5 6
    bspc monitor DVI-D-0 -d 7 8 9 10
    sh ~/.config/polybar/launch.sh
    notify-send "Screen" "Second screen removed..."
  fi
fi
