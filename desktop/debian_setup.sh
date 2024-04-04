#! bin/bash

sudo test

set -e

pause='sleep 2'

# adjusting font size
echo && echo -n "adjusting font size..." && $pause && echo
# sudo dpkg-reconfigure console-setup
# terminua bold
# 16x32

# clean repo
echo && echo -n "cleaning repos..." && $pause
sudo cp -n /etc/apt/sources.list /etc/apt/sources.list.bak
sudo sed -i '/^deb /!d' /etc/apt/sources.list

# update system
echo -e "\n" && echo -n "updating system..." && $pause && echo
sudo apt-get update

# upgrade system
echo && echo -n "upgrading system..." && $pause && echo
sudo apt-get upgrade

# set brightness
echo && echo -n "setting brightness to 5% ..." && $pause && echo
sudo apt-get install brightnessctl -y
brightnessctl set 5%

# disable grub timeout
echo && echo -n "disabling grub timeout..." && $pause
sudo cp -n /etc/default/grub /etc/default/grub.bak
sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub

# update grub
echo -e "\n" && echo -n "updating grub..." && $pause && echo
sudo update-grub

# install vim
echo -e "\n" && echo -n "installing vim..." && $pause && echo
sudo apt-get install vim -y

echo -e "\nAll done!"
