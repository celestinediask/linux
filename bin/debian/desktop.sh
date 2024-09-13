#!/bin/bash
# debian gnome desktop setup

set -e

sudo test || true

USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)

# nautilus items count show
# gnome-text-editor disable restore
# chrome
# firefox

project_root="../../"

source $project_root/debian/system.sh 
source $project_root/gnome.sh 

check_os
comment_out_deb_src

#sudo apt install gnome-session --no-install-recommends --no-install-suggests gdm3 kitty

sudo apt install wpasupplicant network-manager -y
fix_wifi

sudo apt install dbus-x11 -y
gnome_settings_host

# import config
cp -i $project_root/config/vimrc ~/.vimrc

# install packages
#sudo apt install vim mpv eog gnome-text-editor gnome-disk-utility gnome-system-monitor nautilus
