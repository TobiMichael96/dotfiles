#!/bin/bash

if response=$(df /home/tobias/Extern); then
	sudo umount /home/tobias/Extern
fi
sudo cryptsetup luksClose extern

exit 0
