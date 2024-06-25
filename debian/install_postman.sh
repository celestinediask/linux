#!/bin/bash

sudo test

# Check if OS is Debian-based
if ! grep -q "^ID=debian" /etc/os-release; then
    echo "This script is intended for Debian-based distributions only. Exiting."
    exit 1
fi

# Removing existing postman leftovers if any
echo "Removing existing postman leftovers if any..."
sudo rm -r /opt/Postman
sudo rm /usr/bin/postman
sudo rm /usr/share/applications/postman.desktop

# Download Postman tarball
echo "Downloading Postman..."
wget https://dl.pstmn.io/download/latest/linux64 -O postman-linux-x64.tar.gz

# Extract tarball to /opt directory
echo "Extracting Postman..."
sudo tar -xzf postman-linux-x64.tar.gz -C /opt

# Create symbolic link
echo "Creating desktop shortcut icon..."
sudo ln -s /opt/Postman/Postman /usr/bin/postman

# Create desktop entry
echo "Creating desktop entry..."
cat <<EOF | sudo tee /usr/share/applications/postman.desktop
[Desktop Entry]
Name=Postman
Exec=/opt/Postman/Postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
EOF

echo "Removing downloaded file..."
rm postman-linux-x64.tar.gz 

# Verify installation
echo "Verifying installation..."
if command -v postman >/dev/null 2>&1; then
    echo "Postman is installed successfully."
else
    echo "Postman installation failed."
fi