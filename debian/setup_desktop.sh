#!/bin/bash

set -e

sudo test || true

start_time=$(date +%s)

./001_comment_deb_src.sh
./002_install_minimal_packages.sh
./gnome_terminal_enable_bright_colors.sh
./install_essential_packages.sh
../gnome/gsettings_host.sh

# install chrome

# pin gnome terminal to gnome dash
gsettings set org.gnome.shell favorite-apps "['org.gnome.Terminal.desktop']"

# this will disconnect the internet until reboot therefore this line should be placed after all the internet required tasks
./fix_wifi

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "debian gnome minimal host desktop setup has been successfully completed in $execution_time seconds."
