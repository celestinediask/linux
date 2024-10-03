#!/bin/bash

set -e

sudo test || true

start_time=$(date +%s)

./comment_deb_src.sh

sudo apt update

sudo apt install -y gnome-session --no-install-suggests --no-install-recommends

sudo apt install -y gdm3 gnome-terminal network-manager wpasupplicant

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

# this will disconnect the internet until reboot therefore this line should be placed after all the internet required tasks 
./fix_wifi.sh

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "debian gnome minimal host desktop setup has been successfully completed in $execution_time seconds."
