#!/bin/bash
old_service=$(systemctl | grep wg-quick@mullvad | awk '{print $1}')
if [ ! -z "$old_service" ]; then
    sudo systemctl stop $old_service
fi
new_service=wg-quick@mullvad-$1.service
sudo systemctl start $new_service

