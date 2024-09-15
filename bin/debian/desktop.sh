#!/bin/sh
# debian gnome desktop setup

set -e

sudo test || true

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

PROJECT_ROOT="../.."

source $PROJECT_ROOT/debian/system.sh 
source $PROJECT_ROOT/gnome.sh 
source $PROJECT_ROOT/swap.sh
source $PROJECT_ROOT/debian/apps/chrome.sh

check_os
comment_out_deb_src
add_repo_chrome
sudo apt update

sudo apt install gnome-session --no-install-recommends --no-install-suggests gdm3 kitty vim -y
sudo apt install mpv eog evince gnome-text-editor gnome-disk-utility gnome-system-monitor gnome-control-center fonts-mlym nautilus firefox-esr curl dbus-x11 wpasupplicant network-manager google-chrome-stable -y

fix_wifi

gnome_settings_host

set_swap

# setup firefox profile
cd $PROJECT_ROOT/tmp
git clone https://github.com/celestinediask/firefox
./remove_bloat.sh

# import config
cd $PROJECT_ROOT/config
cp -i vimrc ~/.vimrc

cd $SCRIPT_DIR

echo "All done!"
