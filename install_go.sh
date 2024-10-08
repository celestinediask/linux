#!/bin/bash
# go install helper

set -e

start_time=$(date +%s)

ping_server="9.9.9.9"

# Check if Go is installed
if [ -e /usr/local/go/bin/go ]; then
    echo "go is already installed. Skipping..."
    exit 0
fi

# Check if curl and wget are installed
for cmd in curl wget; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed."
        exit 1
    fi
done

# Check for internet connectivity
if ! ping -c 1 $ping_server > /dev/null 2>&1; then
    echo "No internet connection. Exiting..."
    exit 1
fi

sudo test || true

# Step 1: Fetch the latest Go version
LATEST_VERSION=$(curl -s https://go.dev/VERSION?m=text | grep -oE '^go[0-9\.]+')
DOWNLOAD_LINK="https://go.dev/dl/${LATEST_VERSION}.linux-amd64.tar.gz"

# Step 2: Download the latest Go tarball
echo "Downloading $LATEST_VERSION from $DOWNLOAD_LINK..."
if ! wget $DOWNLOAD_LINK -O /tmp/go.tar.gz; then
    echo "Error downloading Go tarball."
    exit 1
fi

# Step 3: Remove any previous Go installation (optional)
echo "Removing old Go installation if any..."
sudo rm -rf /usr/local/go

# Step 4: Extract the new Go tarball to /usr/local
echo "Installing Go $LATEST_VERSION..."
sudo tar -C /usr/local -xzf /tmp/go.tar.gz

# Step 5: Add Go to the system PATH in /etc/profile
if ! grep -q "export PATH=\$PATH:/usr/local/go/bin" ~/.bashrc; then
    echo "Adding Go to your PATH in /etc/profile..."
    echo "export PATH=\$PATH:/usr/local/go/bin" | sudo tee -a ~/.bashrc
fi

export PATH=$PATH:/usr/local/go/bin

# Clean up
sudo rm /tmp/go.tar.gz

# Verify the installation
go version

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "go installation has been successfully completed in $execution_time seconds."

# Inform user to apply new PATH or open a new terminal
echo "Please run 'source ~/.bashrc' in current session."
