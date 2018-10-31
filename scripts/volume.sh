#!/usr/bin/env bash

number=$(pactl list short sinks | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,')
volume=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $number + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,' )
output="Volume: $volume%"

notify() {
	notify-send -u low "Speaker Volume" "$output"
}

output() {
	echo $output
}

case $1 in
	n) notify ;;
	*) output ;;
esac
