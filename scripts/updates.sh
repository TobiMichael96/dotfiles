#!/usr/bin/env bash

if response=$(ping -c 1 1.1.1.1 2> /dev/null); then
  pacman=$(pacman -Qu | wc -l)
  trizen=$(trizen -Qua | wc -l)
  let updates=$pacman+$trizen
  if [ $updates -eq 0 ]; then
    echo ""
  else
    echo "$updates"
  fi
else
  echo ""
fi
