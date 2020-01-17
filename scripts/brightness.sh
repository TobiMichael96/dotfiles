#!/usr/bin/env bash

brightness=$(light)
brightness="Brightness: "$(printf "%.*f\n" 0 $brightness)%

notify() {
	notify-send -u low "Brightness" "$brightness"
}

output() {
	echo $brightness
}

case $1 in
	n) notify ;;
	*) output ;;
esac
