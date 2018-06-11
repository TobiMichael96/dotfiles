#!/usr/bin/env bash

connected=$(xrandr -q | grep " connected" | cut -d ' ' -f1 | sed -n 2p)

if [ ! -z "$connected" ]; then
  sh ~/.screenlayout/withTV.sh
  sleep 1
  feh --bg-fill --randomize ~/.config/background/*
else
  sh ~/.screenlayout/withoutTV.sh
  sleep 1
  feh --bg-fill --randomize ~/.config/background/*
fi
