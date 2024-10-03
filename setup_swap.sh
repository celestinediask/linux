#/bin/bash
# set swap helper

set -e


# Define the swap file path and size
SWAPFILE="/swapfile"

# Prompt the user for a number between 1 and 64
echo -n "Please enter swap size: "
read SWAPSIZE

# Check if the input is within the valid range
if [[ "$SWAPSIZE" -ge 1 && "$SWAPSIZE" -le 64 ]]; then
    # Store the number in a variable and print it
    echo "You entered: $SWAPSIZE"
else
    # Handle the case where the number is out of range
    echo "Error: The swap size must be between 1 and 64."
    exit 0
fi

start_time=$(date +%s)

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

echo "swap size: $SWAPSIZE"
end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "swap setup has been successfully completed in $execution_time seconds."