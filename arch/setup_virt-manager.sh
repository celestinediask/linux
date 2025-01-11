#! /bin/bash
# virt-manager setup on archlinux

set -e

sudo pacman -S --noconfirm virt-manager qemu-desktop libvirt dnsmasq
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service
sudo virsh net-start default
sudo virsh net-autostart default

# uncomment if you use root
#sudo usermod -aG libvirt $(whoami)
