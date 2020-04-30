#!/bin/bash

export DIPLAY=:0

export XSECURELOCK_NO_COMPOSITE=1
export XSECURELOCK_SHOW_DATETIME=1


xsecurelock &
wal -i ~/dotfiles/background
