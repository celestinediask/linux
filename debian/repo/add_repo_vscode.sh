#!/bin/bash
# add vscode repo for debian

set -e

sudo test || true

THIS_SCRIPT=$(basename "$0")
#echo "running: $THIS_SCRIPT"

# Check if the system is Debian-based
if ! grep -q "^ID=debian" /etc/os-release; then
	echo "$THIS_SCRIPT is intended for Debian-based distributions only. Exiting."
	exit 1
fi

# Check if VSCode repo is already added
if [ -f /etc/apt/sources.list.d/vscode.list ]; then
    echo "VSCode repo is already added. Skipping adding vscode repo..."
    exit 0
fi

# Check for internet connectivity
if ! ping -c 1 debian.org > /dev/null 2>&1; then
    echo "No internet connection. Exiting..."
    exit 1
fi

echo "Adding vscode debian repo..."

# install dependencies
sudo apt install -y gpg wget apt-transport-https

# curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/keyrings/microsoft-archive-keyring.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# clean up
rm microsoft.gpg

echo "vscode repo added"
