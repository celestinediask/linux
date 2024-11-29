#!/bin/bash

set -e

THIS_SCRIPT=$(basename "$0")
start_time=$(date +%s)

echo "installing google-chrome directly to debian..."

# Check if the system is Debian-based
if ! grep -q "^ID=debian" /etc/os-release; then
	echo "$THIS_SCRIPT is intended for Debian-based distributions only. Exiting."
	exit 1
fi

# Check if google-chrome-stable is installed
if dpkg -l | grep -q google-chrome-stable; then
    echo "google chrome is already installed. Skipping..."
    exit 0
fi

# Check if wget is installed
if ! command -v wget &> /dev/null; then
    echo "Error: wget is not installed."
    exit 1
fi

# Check for internet connectivity
if ! ping -c 1 debian.org > /dev/null 2>&1; then
    echo "No internet connection. Exiting..."
    exit 1
fi

sudo test || true

wget -P /tmp https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y /tmp/google-chrome-stable_current_amd64.deb
sudo rm /tmp/google-chrome-stable_current_amd64.deb

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "google-chrome installation has been successfully completed in $execution_time seconds."
