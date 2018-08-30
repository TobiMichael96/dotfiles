#!/usr/bin/env bash
file="/home/tobias/Nextcloud/Notes/Ablage.txt"

if [ -f $file ]; then
  echo -ne "\n" >> $file
  echo -n "---" >> $file
  echo -e "\n" >> $file
fi
echo $@ >> $file

echo "Note saved!"
