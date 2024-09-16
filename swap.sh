#/bin/bash
# set swap helper

set -e

set_swap() {
  # Define the swap file path and size
  SWAPFILE="/swapfile"
  SWAPSIZE="1G"
  
  # Check if swap is already enabled
  if sudo swapon --show | grep -q "$SWAPFILE"; then
    echo "Swap file $SWAPFILE is already enabled."
    return
  fi
  
  # Create the swap file
  echo "Creating swap file at $SWAPFILE with size $SWAPSIZE..."
  sudo fallocate -l "$SWAPSIZE" "$SWAPFILE" 2>/dev/null || sudo dd if=/dev/zero of="$SWAPFILE" bs=1M count=$(echo "$SWAPSIZE" | sed 's/G//')000
  if [ $? -ne 0 ]; then
    echo "Failed to create swap file."
    exit 1
  fi
  
  # Set the correct permissions
  sudo chmod 600 "$SWAPFILE"
  
  # Set up the swap space
  sudo mkswap "$SWAPFILE"
  if [ $? -ne 0 ]; then
    echo "Failed to format swap file."
    exit 1
  fi
  
  # Activate the swap file
  sudo swapon "$SWAPFILE"
  if [ $? -ne 0 ]; then
    echo "Failed to enable swap file."
    exit 1
  fi
  
  # Make the swap file permanent by adding it to /etc/fstab
  if ! grep -q "$SWAPFILE" /etc/fstab; then
    #echo "$SWAPFILE none swap sw 0 0" >> /etc/fstab
    echo "$SWAPFILE none swap sw 0 0" | sudo tee -a /etc/fstab
  fi
  
  # Verify the swap space
  sudo swapon --show
  
  echo "Swap file setup complete."
}

set_swap
