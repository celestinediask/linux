#!/bin/bash

set -e

start_time=$(date +%s)

# Check if wget is installed
if ! command -v wget &> /dev/null; then
    echo "wget command not found. Please install wget."
    exit 1
fi

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "jq command not found. Please install jq."
    exit 1
fi

# Check for internet connectivity
if
 ! ping -c 1 9.9.9.9 > /dev/null 2>&1; then
    echo "No internet connection. Exiting..."
    exit 1
fi

# Checking for previously installed leftovers
paths="
/opt/vscodium
/usr/bin/code
/usr/share/applications/vscodium.desktop
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


sudo test || true

# GitHub repository in the format owner/repository
REPO="VSCodium/vscodium"

# Fetch the latest release data from the GitHub API
LATEST_RELEASE=$(curl -s "https://api.github.com/repos/$REPO/releases/latest")

# Extract the URL of the latest .AppImage file
APPIMAGE_URL=$(echo $LATEST_RELEASE | jq -r '.assets[] | select(.name | test(".*\\.AppImage$")) | .browser_download_url')

# Output the URL of the latest .AppImage file
if [ -n "$APPIMAGE_URL" ]; then
    echo "AppImage file URL: $APPIMAGE_URL"
else
    echo "No AppImage file found in the latest release. Exiting."
    exit 1
fi

sudo mkdir "/opt/vscodium"
sudo wget -O "/opt/vscodium/vscodium.AppImage" "$APPIMAGE_URL"

sudo chmod +x /opt/vscodium/vscodium.AppImage

sudo ln -s /opt/vscodium/vscodium.AppImage /usr/bin/code

sudo wget -O /opt/vscodium/vscodium.png "https://raw.githubusercontent.com/etosy/icons/refs/heads/main/vscodium.png"

cat <<EOF | sudo tee /usr/share/applications/vscodium.desktop
[Desktop Entry]
Name=vscodium
Exec=/opt/vscodium/vscodium.AppImage
Icon=/opt/vscodium/vscodium.png
Terminal=false
Type=Application
Categories=Development;

EOF

# Verify installation
echo "Verifying installation..."
if command -v code --version >/dev/null 2>&1; then
	echo "vscodium is installed successfully."
else
	echo "vscodium installation failed."
fi

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "vscodium installation has been successfully completed in $execution_time seconds."
