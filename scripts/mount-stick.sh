stick=31df4720-2a20-4a51-b898-eeaad29522c6

if (ls /dev/disk/by-uuid | grep "504d8a98-ab79-4aa8-9d6c-d7205c4a6cfe" > /dev/null); then
	stick=504d8a98-ab79-4aa8-9d6c-d7205c4a6cfe
fi
stick="/dev/disk/by-uuid/$stick"

sudo cryptsetup luksOpen $stick Stick
sudo mount -o uid=tobias,umask=277 /dev/mapper/Stick ~/Stick

if (df -aTh | grep "/home/tobias/Nextcloud" > /dev/null); then
	sudo cp /home/tobias/Nextcloud/Passwords/Passwords.kdbx ~/Stick/.backup/Passwords_backup.kdbx
fi
