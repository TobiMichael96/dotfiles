#!/bin/bash
old_service=$(systemctl | grep wg-quick@mullvad | grep exited | awk '{print $1}')
if [ ! -z "$old_service" ]; then
    sudo systemctl stop $old_service
fi
if [ ! $1 == "none" ]; then
    new_service=wg-quick@mullvad-$1.service
    sudo systemctl start $new_service
fi
