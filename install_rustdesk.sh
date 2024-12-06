#!/bin/bash

set -e

sudo test || true

start_time=$(date +%s)

missing=""

for cmd in jq curl; do
    if ! command -v $cmd &> /dev/null; then
        missing="$missing$cmd "
    fi
done

if [ -n "$missing" ]; then
    echo "The following commands are missing: $missing"
    echo "Please install the missing commands."
    exit 1
fi

# Checking for previously installed leftovers
paths="
/opt/rustdesk
/usr/bin/rustdesk
/usr/share/applications/rustdesk.desktop
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

ICON_URL="https://raw.githubusercontent.com/etosy/icons/refs/heads/main/rustdesk.png"

response=$(curl -s "https://api.github.com/repos/rustdesk/rustdesk/releases/latest")

download_url=$(echo "$response" | jq -r '.assets[] | select(.name | contains("x86_64.AppImage")) | .browser_download_url')

if [ -z "$download_url" ]; then
    echo "Failed to find the RustDesk AppImage for x86_64 architecture."
    exit 1
fi

sudo mkdir -p /opt/rustdesk

sudo curl -L -o "/opt/rustdesk/rustdesk.AppImage" "$download_url"

sudo curl -o "/opt/rustdesk/rustdesk.png" "$ICON_URL"



if [ $? -ne 0 ]; then
    echo "Failed to download RustDesk AppImage."
    exit 1
fi

sudo chmod +x "/opt/rustdesk/rustdesk.AppImage"


sudo ln -s /opt/rustdesk/rustdesk.AppImage /usr/bin/rustdesk


cat << EOF | sudo tee /usr/share/applications/rustdesk.desktop
[Desktop Entry]
Name=RustDesk
Comment=Remote Desktop Software
Exec=/opt/rustdesk/rustdesk.AppImage
Icon=/opt/rustdesk/rustdesk.png
Terminal=false
Type=Application
Categories=Utility;Network;
EOF

#sudo chmod +x "/usr/share/applications/rustdesk.desktop"

if command -v "rustdesk" &> /dev/null; then
    end_time=$(date +%s)
    execution_time=$((end_time - start_time))
    echo "rustdesk installation has been successfully completed in $execution_time seconds."
else
    echo "RustDesk installation failed."
fi
