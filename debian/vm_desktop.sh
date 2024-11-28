#!/bin/bash
# this script intended for virtual machine desktop setup

set -e

sudo test || true

start_time=$(date +%s)

./comment_deb_src.sh

sudo apt update
sudo apt install -y gnome-session --no-install-suggests --no-install-recommends
sudo apt install -y gdm3 gnome-terminal spice-vdagebt

./gnome_terminal_enable_bright_colors.sh

# switch legacy apps to dark them like gnome-terminal
gsettings set org.gnome.desktop.interface gtk-theme 'HighContrastInverse'

# pin gnome terminal to gnome dash
gsettings set org.gnome.shell favorite-apps "['org.gnome.Terminal.desktop']"

# enable over amplification
#gsettings set org.gnome.desktop.sound allow-volume-above-100-percent 'true'

# auto login

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "debian gnome minimal virtual machine setup has been successfully completed in $execution_time seconds."
