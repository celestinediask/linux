#!/bin/bash
# add vscode repo for debian

set -e

start_time=$(date +%s)

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

# Update package list and upgrade existing packages
sudo apt update && sudo apt upgrade -y

# Install dependencies
sudo apt install -y wget gpg apt-transport-https

echo "Adding vscode debian repo..."
# Download and install the Microsoft GPG key
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
rm packages.microsoft.gpg

# Add the VS Code repository
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

sudo apt update

sudo apt install -y code

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "The script took $execution_time seconds to complete."

echo "code has been installed successfully"
