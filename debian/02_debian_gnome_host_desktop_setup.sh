#!/bin/bash
# debian gnome desktop setup

set -e

start_time=$(date +%s)

PROJECT_ROOT=$(realpath ..)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMP_DIR=$PROJECT_ROOT/tmp

THIS_SCRIPT=$(basename "$0")
#echo "running: $THIS_SCRIPT"

# Check if the system is Debian-based
if ! grep -q "^ID=debian" /etc/os-release; then
	echo "$THIS_SCRIPT is intended for Debian-based distributions only. Exiting."
	exit 1
fi

# exit if temp folder exist
if [ -d "$TEMP_DIR" ]; then
    echo "Please remove '$TEMP_DIR' to proceed."
    exit 1
fi

# Check for internet connectivity
if ! ping -c 1 9.9.9.9 > /dev/null 2>&1; then
    echo "No internet connection. Exiting..."
    exit 1
fi

sudo test || true

sudo apt update

sudo apt install -y fonts-noto-color-emoji dbus-x11 wget curl gnome-calculator cheese gnome-control-center nautilus mpv eog evince gnome-text-editor gnome-disk-utility gnome-system-monitor fonts-mlym fonts-deva firefox-esr

$PROJECT_ROOT/debian/repo/install_chrome.sh

$PROJECT_ROOT/gnome/gsettings_host.sh

# setup firefox profile
if [ ! -d "$TEMP_DIR" ]; then
    mkdir -p "$TEMP_DIR"
    echo "Directory '$TEMP_DIR' has been created."
fi

cd $TEMP_DIR
git clone https://github.com/etosy/firefox
cd firefox
./remove_bloat.sh

cd $SCRIPT_DIR

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "debian gnome host desktop setup has been successfully completed in $execution_time seconds."
