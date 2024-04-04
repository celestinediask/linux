#! /bin/bash

# theme
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface gtk-theme Adwaita

# wallpaper
#gsettings set org.gnome.desktop.background picture-uri 'file:///home/user/.local/share/backgrounds/wallpaper'
#gsettings set org.gnome.desktop.background picture-uri-dark 'file:///home/user/.local/share/backgrounds/wallpaper'

# camera
#gsettings set org.gnome.desktop.privacy disable-camera true

# microphone
#gsettings set org.gnome.desktop.privacy disable-microphone true

# file history
gsettings set org.gnome.desktop.privacy remember-recent-files false

# night light
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 0.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 0.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 4000

# tap to click
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

# lock screen
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.notifications show-in-lock-screen false

# sleep
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 600
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type nothing 600

# battery percentage
gsettings set org.gnome.desktop.interface show-battery-percentage true
