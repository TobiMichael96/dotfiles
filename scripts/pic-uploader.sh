#!/usr/bin/env bash

if [[ -z "$2" ]]; then
 PWD=$(cat ~/Nextcloud/Passwords/Daten/.uploader)
else
 PWD=$2
fi

IMAGE=$1
COUNTER=0

wait_for_connection() {
    for i in {1..5}
    do
     if response=$(ping -c 1 pic.tobiasmichael.de 2> /dev/null); then
        upload_copy_url
        exit 0
     else
        notify-send "Screenshot (retry: $i)" "No connection avaliable, retry in 30 seconds!"
        sleep 3
     fi
    done
}

upload_copy_url() {
    curl --user $USER:$PWD -F "file=@$IMAGE" https://pic.tobiasmichael.de/uploader | xclip
    if [[ $(xclip -o) == *"pic.tobiasmichael.de"*  ]]; then
        xclip -o | xclip -sel clip
        notify-send "Screenshot" "Link saved to clipboard!"
    else
        notify-send "Screenshot" "Failed to upload!"
    fi
}

wait_for_connection
