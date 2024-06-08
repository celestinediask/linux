#! /bin/bash

# theme
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
#gsettings set org.gnome.desktop.interface gtk-theme Adwaita

# tap to click
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true


# battery percentage
gsettings set org.gnome.desktop.interface show-battery-percentage true


# file history
gsettings set org.gnome.desktop.privacy remember-recent-files false

# pin default apps to dock
gsettings set org.gnome.shell favorite-apps "['firefox-esr.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Nautilus.desktop']"


# lock screen notification
#gsettings set org.gnome.desktop.notifications show-in-lock-screen false

# sleep
#gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 600
#gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type nothing 600