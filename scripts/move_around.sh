#!/bin/env sh
DIRECTION=$1

# prepare parameters
if [ "$1" = "next" ]; then
	FOCUSED="east"
	TO_FOCUS="west"
else
	FOCUSED="west"
	TO_FOCUS="east"
fi

# get most left or most right node
IMPORTANT_NODE=$(bspc query -N -n $FOCUSED)
# check if there is a node under the most right node
SECOND_NODE=$(bspc query -N -n south)

if [ -z "$IMPORTANT_NODE" ]; then
	if [ -z "$SECOND_NODE" ]; then
		bspc desktop -f $1.local
		bspc node --focus $TO_FOCUS.local
	else
		bspc node --focus $1.local
	fi
else
	bspc node --focus $1.local
fi
