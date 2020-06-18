#!/bin/env sh
DIRECTION=$1

FOCUSED_NODE=$(bspc query -N -n focused.local)

if [ "$1" = "next" ]; then
	FOCUSED="biggest"
	TO_FOCUS="smallest"
else
	FOCUSED="smallest"
	TO_FOCUS="biggest"
fi


IMPORTANT_NODE=$(bspc query -N -n $FOCUSED.tiled.local)

if [ "$FOCUSED_NODE" = "$IMPORTANT_NODE" ]; then
	bspc desktop -f $1.local
	bspc node --focus $TO_FOCUS.local
else
	bspc node --focus $1.local
fi
