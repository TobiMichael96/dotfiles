#!/usr/bin/env bash

hidden=false
height=$(xdpyinfo | awk -F '[ x]+' '/dimensions:/{print $4}')
barheight=$(cat .config/polybar/config | grep height | head -n1 | sed 's/height.=\ *//')
let height=$height-$barheight

daemon() {
	while true; do
		mouse=$(xdotool getmouselocation --shell | grep Y | sed 's/.=*//')
		if [ "$mouse" -gt "$height" ] && [ "$hidden" = true ]; then
			polybar-msg cmd show
			bspc config bottom_padding $barheight
			hidden=false
		elif [ "$mouse" -lt "$height" ] && [ "$hidden" = false ]; then
			sleep 3
			polybar-msg cmd hide
			bspc config bottom_padding 0
			hidden=true
		fi
		sleep 1
	done &
}

toggle() {
	padding=$(bspc config bottom_padding)
	if [ "$padding" -eq 0 ]; then
		polybar-msg cmd show
		bspc config bottom_padding $barheight
		hidden=false
	else 
		polybar-msg cmd hide
		bspc config bottom_padding 0
		hidden=true
	fi
}

case "$1" in
  t)
  toggle
  ;;
  *)
  daemon
  ;;
esac
