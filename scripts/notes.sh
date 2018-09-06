#!/usr/bin/env bash
file="/home/tobias/Nextcloud/Notes/Ablage/Note_"
file+="$(date +'%d-%m-%Y')"
file+=".txt"

echo -n $(date +'%R') >> $file
echo -n ": " >> $file
echo $@ >> $file
echo -ne "\n" >> $file
echo -n "---" >> $file
echo -e "\n" >> $file

echo "Note saved!"
