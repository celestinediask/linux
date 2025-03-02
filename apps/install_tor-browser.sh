#!/bin/bash

# Exit script if any command fails
set -e

# Variables
start_time=$(date +%s)
TOR_URL="https://www.torproject.org"
DOWNLOAD_PAGE="${TOR_URL}/download/"
INSTALL_DIR="$HOME/.local/share/tor-browser"
DESKTOP_ENTRY_DIR="$HOME/.local/share/applications"
DESKTOP_ENTRY_FILE="${DESKTOP_ENTRY_DIR}/tor-browser.desktop"
ICON_FILE="${INSTALL_DIR}/Browser/browser/chrome/icons/default/default128.png"
ALIAS_NAME=tor-browser

if grep -q "$ALIAS_NAME" ~/.bashrc; then
    echo "Alias '$ALIAS_NAME' found in .bashrc. Please remove it first. Exiting."
    exit 1
fi

paths="
$DESKTOP_ENTRY_FILE
$INSTALL_DIR
"

found_conflict=0

echo "Checking for previously installed leftovers..."
for path in $paths; do
	if [ -e "$path" ] || [ -L "$path" ]; then
	    echo "$path"
	    found_conflict=1
	fi
done

if [ $found_conflict -eq 1 ]; then
	echo "Error: leftovers found. Please remove it to continue installation. Exiting."
	exit 1
fi

echo "Fetching the latest Tor Browser download URL from $DOWNLOAD_PAGE..."

# Download the page content
HTML_CONTENT=$(curl -sL "$DOWNLOAD_PAGE")

# Extract the latest version number from the page (e.g., "14.0.3")
VERSION=$(echo "$HTML_CONTENT" | grep -oP 'tor-browser-linux-x86_64-\K[0-9]+\.[0-9]+\.[0-9]+' | head -n 1)

# Check if the version was found
if [ -z "$VERSION" ]; then
    echo "Error: Failed to fetch the Tor Browser version."
    exit 1
fi

# Construct the full download URL using the extracted version
DOWNLOAD_URL="${TOR_URL}/dist/torbrowser/${VERSION}/tor-browser-linux-x86_64-${VERSION}.tar.xz"

echo "Latest Tor Browser URL: $DOWNLOAD_URL"

mkdir -p "$INSTALL_DIR"

cd "$INSTALL_DIR" || exit

wget -O tor-browser.tar.xz "$DOWNLOAD_URL"

tar -xvf tor-browser.tar.xz --strip-components=1

rm tor-browser.tar.xz

# Create a command alias
echo "alias tor-browser='$INSTALL_DIR/Browser/start-tor-browser'" >> "$HOME/.bashrc"

source ~/.bashrc

# Create a .desktop entry for app list visibility
bash -c "cat > $DESKTOP_ENTRY_FILE <<EOF
[Desktop Entry]
Name=Tor Browser
Exec=$INSTALL_DIR/Browser/start-tor-browser
Icon=$ICON_FILE
Type=Application
EOF"

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "tor-browser installation has been successfully completed in $execution_time seconds."
