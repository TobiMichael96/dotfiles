#!/usr/bin/env bash

# Get battery name
BATN=$(ls /sys/class/power_supply/ | grep BAT)

# Exit if no battery available
if [ -z "$BATN" ]; then
	echo "No battery found" 1>&2
	exit 1
fi

getbat() {
  BATC=$(cat /sys/class/power_supply/${BATN}/capacity)
  BATS=$(cat /sys/class/power_supply/${BATN}/status)
}

daemon() {
	while true
	do
		getbat
		if [ "15" -gt "$BATC" ] && [ "Discharging" = "$BATS" ]; then
			notify-send -u critical "Battery very low!" "Battery at $BATC%!"
		fi
		sleep 180
	done &
}

get() {
  getbat
  echo "Battery: $BATC% - $BATS"
}

case $1 in
	g) get    ;;
	*) daemon ;;
esac
