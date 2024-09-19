#!/bin/bash
# go install helper

set -e

THIS_SCRIPT=$(basename "$0")
ping_server="9.9.9.9"

echo "running: "$THIS_SCRIPT"

# Check if wget is installed
if ! command -v curl &> /dev/null; then
    echo "Error: curl is not installed."
    exit 1
fi

# Check for internet connectivity
if ! ping -c 1 $ping_server > /dev/null 2>&1; then
    echo "No internet connection. Exiting..."
    exit 1
fi

exit
sudo test || true

# Step 1: Fetch the latest Go version
LATEST_VERSION=$(curl -s https://go.dev/VERSION?m=text | grep -oE '^go[0-9\.]+')
DOWNLOAD_LINK="https://go.dev/dl/${LATEST_VERSION}.linux-amd64.tar.gz"

# Step 2: Download the latest Go tarball
echo "Downloading $LATEST_VERSION from $DOWNLOAD_LINK..."
wget $DOWNLOAD_LINK -O /tmp/go.tar.gz

# Step 3: Remove any previous Go installation (optional)
echo "Removing old Go installation if any..."
sudo rm -rf /usr/local/go

# Step 4: Extract the new Go tarball to /usr/local
echo "Installing Go $LATEST_VERSION..."
sudo tar -C /usr/local -xzf /tmp/go.tar.gz

# Step 5: Add Go to the system PATH in ~/.bashrc (instead of ~/.profile)
if ! grep -q "export PATH=\$PATH:/usr/local/go/bin" ~/.bashrc; then
    echo "Adding Go to your PATH in ~/.bashrc..."
    echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc
fi

# Step 6: Apply the new PATH
source ~/.bashrc

# Clean up
sudo rm /tmp/go.tar.gz

# Verify the installation
go version
