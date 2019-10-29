#!/usr/bin/env bash
connected=$(cat /sys/class/drm/card0/card0-HDMI-A-1/status)
if [ "$connected" == "connected" ]; then
        sed -i 's/HandleLidSwitch=.*/HandleLidSwitch=ignored/' /etc/systemd/logind.conf
        sed -i 's/HandleLidSwitchExternalPower=.*/HandleLidSwitchExternalPower=ignored/' /etc/systemd/logind.conf
else
        sed -i 's/HandleLidSwitch=.*/HandleLidSwitch=suspend/' /etc/systemd/logind.conf
        sed -i 's/HandleLidSwitchExternalPower=.*/HandleLidSwitchExternalPower=suspend/' /etc/systemd/logind.conf
fi

