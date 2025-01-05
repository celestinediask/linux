#!/bin/bash
# arch daily driver

set -e

start_time=$(date +%s)

cp bashrc ~/.bashrc

sudo pacman -Syu
sudo pacman -S --needed --noconfirm - < ../packages.txt

# gnome setup
sudo pacman -S --needed --noconfirm - < ../gnome/core_packages.txt
sudo pacman -S --needed --noconfirm - < ../gnome/essential_packages.txt
# gsettings

sudo systemctl enable gdm

# setup yay

# setup bluetooth
sudo pacman -S bluez bluez-utils
sudo systemctl start bluetooth
sudo systemctl enable bluetooth

# setup browser
sudo pacman -S --noconfirm firefox
# setup firefox profile
sudo pacman -S firefox-ublock-origin
sudo pacman -S firefox-dark-reader

sudo pacman -S --noconfirm chromium

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "successfully configured arch as daily driver in $execution_time seconds."
