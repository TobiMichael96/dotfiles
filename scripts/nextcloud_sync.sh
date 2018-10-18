#!/bin/bash

pass=$(cat ~/.nextcloud)

owncloudcmd -u TobiMichael -p $pass /home/tobias/Nextcloud_sync/ https://cloud.tobiasmichael.de &
