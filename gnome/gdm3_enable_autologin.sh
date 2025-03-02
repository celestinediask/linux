#!/bin/bash
# Function to enable autologin for current user in GDM

set -e

echo "running: $THIS_SCRIPT"

# Get current username
CURRENT_USER=$(whoami)

sudo test || true

# Set GDM configuration file
GDM_CONFIG_FILE="/etc/gdm3/daemon.conf"

if [ ! -f "$GDM_CONFIG_FILE" ]; then
    echo "file: $GDM_CONFIG_FILE not found"
    exit 0
fi

# Enable autologin for the current user
sudo sed -i 's/# *\(AutomaticLoginEnable\).*/\1 = true/' $GDM_CONFIG_FILE
sudo sed -i "s/# *\(AutomaticLogin\).*/\1 = $CURRENT_USER/" $GDM_CONFIG_FILE

echo "Autologin enabled for $CURRENT_USER."
