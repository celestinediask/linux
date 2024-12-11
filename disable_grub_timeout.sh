#!/bin/bash

set -e

sudo test || true

# Path to the GRUB configuration file
GRUB_FILE="/etc/default/grub"

# Check if the GRUB file exists
if [[ ! -f $GRUB_FILE ]]; then
    echo "GRUB configuration file not found at $GRUB_FILE" >&2
    exit 1
fi

# Backup the original GRUB file
sudo cp "$GRUB_FILE" "$GRUB_FILE.bak"

# Update GRUB_TIMEOUT setting
sudo sed -i 's/^GRUB_TIMEOUT=.*$/GRUB_TIMEOUT=0/' "$GRUB_FILE"

# Update GRUB configuration
echo "Updating GRUB configuration..."
sudo update-grub

echo "GRUB timeout has been disabled. Original configuration backed up as $GRUB_FILE.bak"
