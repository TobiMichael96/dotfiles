#!/usr/bin/env bash

uptime=$(uptime | awk '{print $3, $4, $5}' | sed 's/,$//')
isuser=$(echo $uptime | awk '{print $3}')

echo $uptime
echo $isuser

if [ "$isuser" = "user" ]; then
	uptime=$(uptime | awk '{print $3}' | sed 's/,$//')
	uptime=$uptime" hours"
fi

echo $uptime
