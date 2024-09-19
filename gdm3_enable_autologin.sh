#!/bin/bash
# Function to enable autologin for current user in GDM

set -e

# Get current username
CURRENT_USER=$(whoami)

# Check if gdm3 is installed
if ! dpkg -l | grep -q gdm3; then
    echo "gdm3 is not installed. Exiting."
    exit 1
fi

# Set GDM configuration file
GDM_CONFIG_FILE="/etc/gdm3/daemon.conf"

# Enable autologin for the current user
sudo sed -i 's/# *\(AutomaticLoginEnable\).*/\1 = true/' $GDM_CONFIG_FILE
sudo sed -i "s/# *\(AutomaticLogin\).*/\1 = $CURRENT_USER/" $GDM_CONFIG_FILE

echo "Autologin enabled for $CURRENT_USER."
