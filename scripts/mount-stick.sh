stick=0d87e841-f4ef-4b3e-87b1-c05e7fd02f0f

if (ls /dev/disk/by-uuid | grep "504d8a98-ab79-4aa8-9d6c-d7205c4a6cfe" > /dev/null); then
	stick=504d8a98-ab79-4aa8-9d6c-d7205c4a6cfe
fi
stick="/dev/disk/by-uuid/$stick"

sudo cryptsetup luksOpen $stick Stick
sudo mount -o uid=tobias,umask=277 /dev/mapper/Stick ~/Stick

if (df -aTh | grep "/home/tobias/Nextcloud" > /dev/null); then
	sudo cp /home/tobias/Nextcloud/Passwords/Passwords.kdbx ~/Stick/.backup/Passwords_backup.kdbx
fi
