#!/usr/bin/env bash
file="/home/tobias/Nextcloud/Notes/Ablage.txt"

echo $@ >> $file
echo -ne "\n" >> $file
echo -n "---" >> $file
echo -e "\n" >> $file

echo "Note saved!"
