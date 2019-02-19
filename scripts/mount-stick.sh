sudo cryptsetup luksOpen /dev/disk/by-uuid/504d8a98-ab79-4aa8-9d6c-d7205c4a6cfe Stick
sudo mount -o uid=tobias,umask=277 /dev/mapper/Stick ~/Stick

if (df -aTh | grep "/home/tobias/Nextcloud" > /dev/null); then
	sudo cp /home/tobias/Nextcloud/Passwords/Passwords.kdbx ~/Stick/.backup/Passwords_backup.kdbx
fi
