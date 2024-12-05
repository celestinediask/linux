#!/bin/bash
# custom gnome settings for guest
echo "setting gnome settings for guest machine..."
	
# disable automatic screenlock
gsettings set org.gnome.desktop.screensaver lock-enabled false

# disable automatic screen blank
gsettings set org.gnome.desktop.session idle-delay 0

# switch legacy apps to dark them like gnome-terminal
gsettings set org.gnome.desktop.interface gtk-theme 'HighContrastInverse'

# set dark theme
gsettings set org.gnome.desktop.interface color-scheme prefer-dark

# pin gnome terminal to gnome dash
gsettings set org.gnome.shell favorite-apps "['org.gnome.Terminal.desktop']"

# disable lock screen
gsettings set org.gnome.desktop.screensaver lock-enabled false

# disable screen blanking
#gsettings set org.gnome.desktop.session idle-delay 0

# enable over amplification
#gsettings set org.gnome.desktop.sound allow-volume-above-100-percent 'true'

echo "custom gnome settings for guest machine applied"
