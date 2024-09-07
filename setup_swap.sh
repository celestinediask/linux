#!/bin/bash

# Define the swap file path and size
SWAPFILE="/swapfile"
SWAPSIZE="8G"

# Check if the script is run as root
if [ "$(id -u)" -ne "0" ]; then
  echo "This script must be run as root."
  exit 1
fi

# Check if swap is already enabled
if swapon --show | grep -q "$SWAPFILE"; then
  echo "Swap file $SWAPFILE is already enabled."
  exit 0
fi

# Create the swap file
echo "Creating swap file at $SWAPFILE with size $SWAPSIZE..."
fallocate -l "$SWAPSIZE" "$SWAPFILE" 2>/dev/null || dd if=/dev/zero of="$SWAPFILE" bs=1M count=$(echo "$SWAPSIZE" | sed 's/G//')000
if [ $? -ne 0 ]; then
  echo "Failed to create swap file."
  exit 1
fi

# Set the correct permissions
chmod 600 "$SWAPFILE"

# Set up the swap space
mkswap "$SWAPFILE"
if [ $? -ne 0 ]; then
  echo "Failed to format swap file."
  exit 1
fi

# Activate the swap file
swapon "$SWAPFILE"
if [ $? -ne 0 ]; then
  echo "Failed to enable swap file."
  exit 1
fi

# Make the swap file permanent by adding it to /etc/fstab
if ! grep -q "$SWAPFILE" /etc/fstab; then
  echo "$SWAPFILE none swap sw 0 0" >> /etc/fstab
fi

# Verify the swap space
swapon --show

echo "Swap file setup complete."
