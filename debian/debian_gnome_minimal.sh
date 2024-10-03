#!/bin/bash

set -e

# switch to dark theme
# enable tap to click

start_time=$(date +%s)

./comment_deb_src.sh

sudo apt update

sudo apt install -y gnome-session --no-install-suggests --no-install-recommends

sudo apt install gdm3 gnome-terminal

# switch legacy apps to dark them like gnome-terminal
gsettings set org.gnome.desktop.interface gtk-theme 'HighContrastInverse'

# pin gnome terminal to gnome dash
gsettings set org.gnome.shell favorite-apps "['org.gnome.Terminal.desktop']"

# enable tap to click
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

# show battery percentage
gsettings set org.gnome.desktop.interface show-battery-percentage true

# enable over amplification
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent 'true'

end_time=$(date +%s)

execution_time=$((end_time - start_time))

echo "debian gnome minimal env has been successfully completed in $execution_time seconds."