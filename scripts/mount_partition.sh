#!/bin/bash

sudo cryptsetup luksOpen /dev/sda2 extern && sudo mount /dev/mapper/extern /home/tobias/Extern

exit 0
