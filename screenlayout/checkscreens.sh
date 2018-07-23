#!/usr/bin/env bash
used=$(xrandr -q | grep "HDMI-A-0")
used=${used:19:4}

if ! [[ $used =~ ^[0-9]+$ ]]; then
  sh ~/.screenlayout/withTV.sh
  sleep 1
  ~/.config/bspwm/bspwmrc
  notify-send "Screen" "Second screen added..."
else
  sh ~/.screenlayout/withoutTV.sh
  sleep 1
  ~/.config/bspwm/bspwmrc
  bspc monitor HDMI-A-1 -d 1 2 3 4 5 6
  bspc monitor DVI-D-0 -d 7 8 9 10
  feh --bg-fill --randomize ~/.config/background/*
  ~/.config/scripts/pywal.sh
  notify-send "Screen" "Second screen removed..."
fi
