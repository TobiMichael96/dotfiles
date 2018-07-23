#!/bin/sh

if [ $1 -eq 1 ]; then
	wget http://192.168.2.53/cm?cmnd=Power%20on 2>/dev/null
else
	wget http://192.168.2.53/cm?cmnd=Power%20off 2>/dev/null
fi
