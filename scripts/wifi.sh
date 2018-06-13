#!/usr/bin/env bash

wifi=$(wpa_cli status | grep ssid | tail -n1 | cut -d '=' -f2-)

if [ -z "$wifi" ]; then
	echo "Not connected to WiFi"
else
	echo "SSID: $wifi"
fi

exit 0
