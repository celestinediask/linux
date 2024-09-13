#!/bin/bash
# debian gnome desktop setup

set -e

sudo test || true

project_root="../.."

source $project_root/debian/system.sh 
source $project_root/gnome.sh 
source $project_root/swap.sh
source $project_root/debian/apps/chrome.sh

check_os

comment_out_deb_src

sudo apt install gnome-session --no-install-recommends --no-install-suggests gdm3 kitty vim -y
sudo apt install mpv eog evince gnome-text-editor gnome-disk-utility gnome-system-monitor gnome-control-center fonts-mlym nautilus firefox-esr curl dbus-x11 wpasupplicant network-manager google-chrome-stable -y


add_repo_chrome

sudo apt update

fix_wifi

gnome_settings_host

set_swap

# setup firefox profile
#git clone https://github.com/celestinediask/firefox $project_root/tmp/firefox
#$project_root/tmp/firefox/remove_bloat.sh

# import config
cp -i $project_root/config/vimrc ~/.vimrc

echo "All done!"
