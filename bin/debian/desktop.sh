#!/bin/sh
# debian gnome desktop setup

set -e

sudo test || true

PROJECT_ROOT="../.."
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMP_DIR=$PROJECT_ROOT/tmp

THIS_SCRIPT=$(basename "$0")
echo "running: $THIS_SCRIPT"

# Check if the system is Debian-based
if ! grep -q "^ID=debian" /etc/os-release; then
	echo "$THIS_SCRIPT is intended for Debian-based distributions only. Exiting."
	exit 1
fi

# Check for internet connectivity
if ! ping -c 1 9.9.9.9 > /dev/null 2>&1; then
    echo "No internet connection. Exiting..."
    exit 1
fi

$PROJECT_ROOT/debian/comment_deb_src.sh

$PROJECT_ROOT/debian/repo/add_repo_google.sh

sudo apt update

# install packages
sudo apt install -y gnome-session --no-install-recommends --no-install-suggests
sudo apt install -y gdm3
sudo apt install -y kitty
sudo apt install -y vim
sudo apt install -y mpv
sudo apt install -y eog
sudo apt install -y evince
sudo apt install -y gnome-text-editor
sudo apt install -y gnome-disk-utility
sudo apt install -y gnome-system-monitor
sudo apt install -y gnome-control-center
sudo apt install -y fonts-mlym
sudo apt install -y nautilus
sudo apt install -y firefox-esr
sudo apt install -y curl 
sudo apt install -y dbus-x11 
sudo apt install -y wpasupplicant 
sudo apt install -y network-manager 
sudo apt install -y google-chrome-stable


$PROJECT_ROOT/debian/fix_wifi.sh

$PROJECT_ROOT/gnome/gsettings_host.sh

# setup firefox profile
if [ ! -d "$TEMP_DIR" ]; then
    mkdir -p "$TEMP_DIR"
    echo "Directory '$TEMP_DIR' has been created."
else
    echo "Directory '$TEMP_DIR' already exists."
fi

cd $TEMP_DIR
git clone https://github.com/celestinediask/firefox
./remove_bloat.sh

# import config
cd $PROJECT_ROOT/config
cp -i vimrc ~/.vimrc

cd $SCRIPT_DIR

echo "All done!"