#!/bin/bash
# install essential packages for debian

start_time=$(date +%s)

sudo apt update

sudo apt install -y fonts-noto-color-emoji dbus-x11 wget curl gnome-calculator cheese gnome-control-center nautilus mpv eog evince gnome-text-editor gnome-disk-utility gnome-system-monitor fonts-mlym fonts-deva firefox-esr

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "successfully installed essential packages for debian in $execution_time seconds."
