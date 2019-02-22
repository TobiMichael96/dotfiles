#!/bin/bash

echo "All aliases:"

while IFS='' read -r line || [[ -n "$line" ]]; do
    if [[ $line == *"alias "* ]]; then
	echo "$line"
    fi
done < ~/.zshrc
