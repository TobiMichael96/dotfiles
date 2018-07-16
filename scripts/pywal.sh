#!/bin/bash

wal -i $(cat .fehbg | tail -n 1 | awk '{print $3}' | sed 's/^.\(.*\).$/\1/')
