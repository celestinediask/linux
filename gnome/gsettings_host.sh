#!/bin/bash

set -e

gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'HighContrastInverse'
gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'
gsettings set org.gnome.desktop.privacy remember-recent-files false
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.shell favorite-apps "['org.gnome.Console.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.TextEditor.desktop', 'firefox-esr.desktop', 'firefox.desktop', 'chromium.desktop']"
gsettings set org.gnome.desktop.background primary-color '#000000' # black
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent 'true'
gsettings set org.gnome.nautilus.icon-view captions "['none', 'size', 'none']"
gsettings set org.gnome.TextEditor restore-session false

echo "successfully applied custom gnome settings for host machine"
