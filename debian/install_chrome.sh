set -e

# Check if running with root privilage
if [ "$(id -u)" != "0" ]; then
    if ! sudo -n true 2>/dev/null; then
        echo "This script requires root privileges to execute."
    fi
    
    sudo sh "$0" "$@"
    exit $?
fi

wget -P /tmp https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo apt install -y /tmp/google-chrome-stable_current_amd64.deb

sudo rm /tmp/google-chrome-stable_current_amd64.deb



