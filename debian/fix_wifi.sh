#!/bin/bash

set -e

THIS_SCRIPT=$(basename "$0")
#echo "running: $THIS_SCRIPT"

# Check if the system is Debian-based
if ! grep -q "^ID=debian" /etc/os-release; then
	echo "$THIS_SCRIPT is intended for Debian-based distributions only. Exiting."
	exit 1
fi

# Check if the /etc/network/interfaces file exists
if [ ! -f /etc/network/interfaces ]; then
    echo "/etc/network/interfaces does not exist. skipping wifi fix..."
    exit 0
fi

sudo mv -i /etc/network/interfaces ~/etc/network/_interfaces.bak
sudo systemctl restart wpa_supplicant.service
sudo systemctl restart NetworkManager

echo "successfully fixed wifi"
