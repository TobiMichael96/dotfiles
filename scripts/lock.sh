#!/bin/bash

export DIPLAY=:0

python /home/tobias/mqtt-status.py sleep

slock &
