#!/bin/bash

# check if running with root privilage

if ! grep -q "^ID=debian" /etc/os-release; then
    echo "This script is intended for Debian-based distributions only. Exiting."
    exit 1
fi

if ! command -v xbindkeys &> /dev/null; then
    echo "xbindkeys not found. Installing..."
    sudo apt-get update
    sudo apt-get install -y xbindkeys
fi

if ! command -v xdotool &> /dev/null; then
    echo "xdotool not found. Installing..."
    sudo apt-get update
    sudo apt-get install -y xdotool
fi

cat << EOF > ~/.xbindkeysrc
"xdotool key super"
    b:2 + release
EOF

killall xbindkeys
xbindkeys -p

echo "Middle click is now set to invoke the Super key."

