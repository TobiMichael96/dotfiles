#!/usr/bin/env bash

TOKEN=$(lpass show ImgurToken --notes)
IMAGE=/tmp/screenshot.png

upload_copy_url() {
  if response=$(ping -c 1 1.1.1.1 2> /dev/null); then
    link=$(curl --compressed -fsSL -F "image=@\"${IMAGE}\"" -H "Authorization: Bearer ${TOKEN}" https://api.imgur.com/3/image | sed -E 's/.*"link":"([^"]+)".*/\1/' | sed "s|\\\\/|/|g")
    echo $link | xclip -selection c
    notify-send "Screenshot" "Screenshot saved to clipboard! $link"
  else
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
  fi
}

case "$1" in
  s)
  scrot -s $IMAGE
  upload_copy_url
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
  upload_copy_url
  ;;
esac

exit 0
