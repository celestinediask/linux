#!/bin/bash

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Use sudo." >&2
    exit 1
fi

# Path to the GRUB configuration file
GRUB_FILE="/etc/default/grub"

# Check if the GRUB file exists
if [[ ! -f $GRUB_FILE ]]; then
    echo "GRUB configuration file not found at $GRUB_FILE" >&2
    exit 1
fi

# Backup the original GRUB file
cp "$GRUB_FILE" "$GRUB_FILE.bak"

# Update GRUB_TIMEOUT setting
sed -i 's/^GRUB_TIMEOUT=.*$/GRUB_TIMEOUT=0/' "$GRUB_FILE"

# Update GRUB configuration
echo "Updating GRUB configuration..."
update-grub

echo "GRUB timeout has been disabled. Original configuration backed up as $GRUB_FILE.bak"
