#!/bin/bash
# add vscode repo for debian

set -e

sudo test || true

THIS_SCRIPT=$(basename "$0")

# Check if the system is Debian-based
if ! grep -q "^ID=debian" /etc/os-release; then
	echo "$THIS_SCRIPT is intended for Debian-based distributions only. Exiting."
	exit 1
fi

add_vscode_repo() {
	echo "Adding vscode repo..."
	sudo apt install -y wget gpg #gnupg
	# curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
	sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/keyrings/microsoft-archive-keyring.gpg
	sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
	sudo apt install apt-transport-https
	
	echo "vscode repo added"
 }
