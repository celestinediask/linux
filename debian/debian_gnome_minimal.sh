#!/bin/bash

set -e

# switch to dark theme
# enable tap to click

start_time=$(date +%s)

./comment_deb_src.sh

sudo apt update

sudo apt install -y gnome-session gdm3 gnome-terminal

# pin gnome terminal to gnome dash
gsettings set org.gnome.shell favorite-apps "['org.gnome.Terminal.desktop']"

end_time=$(date +%s)

execution_time=$((end_time - start_time))

echo "debian gnome minimal env has been successfully completed in $execution_time seconds."