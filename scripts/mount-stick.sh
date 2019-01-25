sudo cryptsetup luksOpen /dev/disk/by-uuid/504d8a98-ab79-4aa8-9d6c-d7205c4a6cfe Stick
sudo mount -o uid=tobias,umask=077 /dev/mapper/Stick ~/Stick
