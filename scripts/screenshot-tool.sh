#!/usr/bin/env bash

TOKEN=$(cat ~/.imgurtoken)
IMAGE=/tmp/screenshot.png

counter=0

wait_for_connection() {
    if response=$(ping -c 1 1.1.1.1 2> /dev/null); then
	upload_copy_url
    else
	if (( $counter < 20 )); then
	    sleep 30
            notify-send "Screenshot" "No connection avaliable, retry in 30 seconds!"
	    counter=$((counter++))
	    wait_for_connection
	else
	    save_local
	fi
    fi
}

upload_copy_url() {
    link=$(curl --compressed -fsSL -F "image=@\"${IMAGE}\"" -H "Authorization: Bearer ${TOKEN}" https://api.imgur.com/3/image | sed -E 's/.*"link":"([^"]+)".*/\1/' | sed "s|\\\\/|/|g")
    echo $link | xclip -selection c
    notify-send "Screenshot" "Link saved to clipboard! $link"
}

save_local() {
    echo "No connection avaliable... Screenshot saved offline."
    date=$(date +"%d_%m_%Y")
    name=Screenshot-$date
    if [ -e $name.png ] ; then
      i=1
      while [ -e $name-$i.png ] ; do
        i=$((i+1))
      done
      name=$name-$i.png
    else
      name=$name.png
    fi

    mv $IMAGE ~/Pictures/$name
    notify-send "Screenshot" "Screenshot saved offline... $name"
}

case "$1" in
  s)
  scrot -s $IMAGE
  wait_for_connection
  ;;
  help)
  echo "Usage: $0 [ (full screenshot)|d (full screenshot with delay)|s (partial screenshot)|help]"
  exit 0
  ;;
  d)
  scrot -d 3 $IMAGE
  upload_copy_url
  ;;
  *)
  scrot $IMAGE
  wait_for_connection
  ;;
esac

exit 0
