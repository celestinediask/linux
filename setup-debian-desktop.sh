#!/bin/bash

set -e

USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)

# nautilus items count show
# gnome-text-editor disable restore
# chrome
# firefox

source ./debian/system.sh
source ./gnome.sh

check_os
check_root
comment_out_deb_src

#sudo apt install gnome-session --no-install-recommends --no-install-suggests gdm3 kitty

sudo apt install wpasupplicant -y
fix_wifi

sudo apt install dbus-x11 -y
gnome_settings_host

# import config
cp -i ./config/vimrc $USER_HOME/.vimrc

# install packages
#sudo apt install vim mpv eog gnome-text-editor gnome-disk-utility gnome-system-monitor nautilus