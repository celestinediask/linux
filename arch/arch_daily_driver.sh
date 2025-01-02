#!/bin/bash
# arch daily driver

set -e

start_time=$(date +%s)


cp bashrc ~/.bashrc

sudo pacman -Syu
sudo pacman -S --needed --noconfirm - < ../packages.txt

# gnome setup
# install gnome core packages
sudo pacman -S --needed --noconfirm - < ../gnome/core_packages.txt
sudo systemctl enable gdm
sudo pacman -S --needed --noconfirm - < ../gnome/essential_packages.txt

# setup browser
sudo pacman -S firefox chromium

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "successfully configured arch as daily driver in $execution_time seconds."