#!/usr/bin/env bash

number=$(pactl list short sinks | grep "Analog" | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,')
volume=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(($number + 1)) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,' )
mute=$(pactl list sinks | grep '^[[:space:]]Mute:' | head -n $(($number + 1)) | tail -n 1 | sed -e 's/^[ \t]*//')
output="Volume: $volume%"

notify() {
	notify-send -u low "$output" "$mute"
}

output() {
	echo $output
}

case $1 in
	n) notify ;;
	*) output ;;
esac
