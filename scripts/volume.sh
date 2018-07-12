#!/usr/bin/env bash

volume=$(pactl list sinks | grep  'Volume' | head -n1 | awk '{print $5}')
muted=$(amixer | grep "Mono: Playback" | head -n1 | awk '{print $6}' | tr -d '[]')

if [ "$muted" = "off" ]; then
  output="Volume: $volume MUTED"
else
  output="Volume: $volume"
fi

notify() {
	notify-send -u low "Volume" "$output"
}

output() {
	echo $output
}

case $1 in
	n) notify ;;
	*) output ;;
esac

