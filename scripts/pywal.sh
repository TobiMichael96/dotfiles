#!/bin/bash

feh --bg-fill --no-xinerama --randomize ~/.config/background/*
wal -i $(cat .fehbg | tail -n 1 | awk '{print $4}' | sed 's/^.\(.*\).$/\1/')
