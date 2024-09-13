#!/bin/bash

set -e

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

fix_wifi
sudo apt install dbus-x11
gnome_settings_host

# install packages
sudo apt install vim mpv eog gnome-text-editor gnome-disk-utility gnome-system-monitor nautilus

# chrome

# firefox

# import config
cp -i ~/.config/* ~/.config