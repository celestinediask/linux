#!/bin/bash

set -e

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

echo "Adding google-chrome repo..."
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo tee /etc/apt/trusted.gpg.d/google.asc >/dev/null
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
echo "chrome repo added"
