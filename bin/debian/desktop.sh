#!/bin/bash
# debian gnome desktop setup

set -e

sudo test || true

project_root="../../"

source $project_root/debian/system.sh 
source $project_root/gnome.sh 
source $project_root/swap.sh
source $project_root/debian/apps/chrome.sh

check_os

comment_out_deb_src

add_repo_chrome

sudo apt update

sudo apt install wpasupplicant network-manager -y
fix_wifi

sudo apt install dbus-x11 -y
gnome_settings_host

set_swap

# import config
cp -i $project_root/config/vimrc ~/.vimrc

# install packages
exit
sudo apt install gnome-session --no-install-recommends --no-install-suggests -y
sudo apt install vim mpv eog evince gnome-text-editor gnome-disk-utility gnome-system-monitor gnome-control-center fonts-mlym nautilus kitty firefox-esr curl google-chrome-stable -y

# setup firefox profile
wget -qO- https://raw.githubusercontent.com/celestinediask/firefox/main/remove_bloat.sh | bash
