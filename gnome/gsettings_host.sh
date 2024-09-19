#!/bin/bash
# gnome gsettings for host machine

set -e

echo "setting gnome settings for host machine..."
# set dark theme
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'HighContrastInverse' # for legacy apps

# set icon theme
gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'
  
# disable file history
gsettings set org.gnome.desktop.privacy remember-recent-files false

# enable tap to click
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

# show battery percentage
gsettings set org.gnome.desktop.interface show-battery-percentage true

# set favorite apps
gsettings set org.gnome.shell favorite-apps "['kitty.desktop', 'org.gnome.Nautilus.desktop', 'firefox-esr.desktop', 'firefox.desktop', 'google-chrome.desktop']"

# set background color
gsettings set org.gnome.desktop.background primary-color '#023c88' # blue

# enable over amplification
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent 'true'

echo "custom gnome settings applied"
