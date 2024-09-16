#!/bin/bash
# custom gnome settings for guest
echo "setting gnome settings for guest machine..."
	
# disable automatic screenlock
gsettings set org.gnome.desktop.screensaver lock-enabled false

# disable automatic screen blank
gsettings set org.gnome.desktop.session idle-delay 0

echo "custome gnome settings for guest machine applied"
