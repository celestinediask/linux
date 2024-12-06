#!/bin/bash
# custom gnome settings for guest
echo "overwriting gnome settings for guest machine..."
	
# disable automatic screenlock
gsettings set org.gnome.desktop.screensaver lock-enabled false

# disable automatic screen blank
gsettings set org.gnome.desktop.session idle-delay 0

# pin gnome terminal to gnome dash
gsettings set org.gnome.shell favorite-apps "['org.gnome.Terminal.desktop']"

echo "custom gnome settings for guest machine applied"
