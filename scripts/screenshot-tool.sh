#!/usr/bin/env bash

if [[ -z "$2" ]]; then
 TOKEN=$(cat ~/.seafile)
else
 TOKEN=$2
fi

date=$(date +"%d_%m_%Y")
name=Screenshot-$date.png
IMAGE=/tmp/$name
COUNTER=0

wait_for_connection() {
    for i in {1..5}
    do
     if response=$(ping -c 1 1.1.1.1 2> /dev/null); then
        upload_copy_url
	exit 0
     else
       	notify-send "Screenshot (retry: $i)" "No connection avaliable, retry in 30 seconds!"
       	sleep 3
     fi
    done
    save_local
}

upload_copy_url() {
    link=$(curl -sS -H 'Authorization: Token ${TOKEN}' -F file=@${IMAGE} -F parent_dir=/Screenshots https://seafile.tobiasmichael.de/seafhttp/upload-api/c7325769-d59f-4b22-836e-76d693b24ff1)
    echo $link | xclip -selection c
    notify-send "Screenshot" "Link saved to clipboard! $link"
}

save_local() {
    echo "No connection avaliable... Screenshot saved offline."
    if [ -f ~/Pictures/Screenshots/$name.png ] ; then
      i=1
      while [ -f ~/Pictures/Screenshots/$name-$i.png ] ; do
        i=$((i+1))
      done
      name=$name-$i.png
    else
      name=$name.png
    fi

    mv $IMAGE ~/Pictures/Screenshots/$name
    notify-send "Screenshot" "Screenshot saved offline... $name"
}

case "$1" in
  f)
  scrot $IMAGE
  wait_for_connection
  ;;
  s)
  scrot -s $IMAGE
  wait_for_connection
  ;;
  help)
  echo "Usage: $0 [f (full screenshot)|d (full screenshot with delay)|s (partial screenshot)|help] [(optional) LinxAPI]"
  exit 0
  ;;
  d)
  scrot -d 3 $IMAGE
  upload_copy_url
  ;;
  *)
  echo "Usage: $0 [f (full screenshot)|d (full screenshot with delay)|s (partial screenshot)|help] [(optional) LinxAPI]"
  exit 0
  ;;
esac

exit 0
