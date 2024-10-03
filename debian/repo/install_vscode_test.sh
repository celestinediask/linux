#!/bin/bash

set -e

start_time=$(date +%s)

URL="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"

THIS_SCRIPT=$(basename "$0")
#echo "running: $THIS_SCRIPT"

# Check if the system is Debian-based
if ! grep -q "^ID=debian" /etc/os-release; then
	echo "$THIS_SCRIPT is intended for Debian-based distributions only. Exiting."
	exit 1
fi

# exit if code is already installed
if command -v code &> /dev/null; then
    echo "code is alreay installed. Skipping..."
    exit 0
fi

# Check if code repo is already added
if [ -f /etc/apt/sources.list.d/vscode.list ]; then
    echo "VSCode repo is already added. Skipping..."
    exit 0
fi

# Check for internet connectivity
if ! ping -c 1 debian.org > /dev/null 2>&1; then
    echo "No internet connection. Exiting..."
    exit 1
fi

sudo test || true

echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections

wget $URL -O vscode.deb

sudo apt install ./vscode.deb

rm vscode.deb

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "completed in $execution_time seconds"

echo "vscode has been successfully installed."
