
# Check if running with root privilage
if [ "$(id -u)" != "0" ]; then
    if ! sudo -n true 2>/dev/null; then
        echo "This script requires root privileges to execute."
    fi
    
    sudo sh "$0" "$@"
    exit $?
fi

# Checking for previously installed postman leftovers
paths="
/opt/Postman
/usr/bin/postman
/usr/share/applications/postman.desktop
"

found_conflict=0

echo "Checking for previously installed postman leftovers..."
for path in $paths; do
    if [ -e "$path" ]; then
        echo "$path"
        found_conflict=1
    fi
done

if [ $found_conflict -eq 1 ]; then
    echo "Error: postman leftovers found. Please remove it to install postman. Exiting."
    exit 1
fi

# Check if previously downloaded file exists
if [ -f "/tmp/postman-linux-x64.tar.gz" ]; then
    sudo rm /tmp/postman-linux-x64.tar.gz
    echo "File /tmp/postman-linux-x64.tar.gz removed."
fi

# Download Postman tarball to temp storage
echo "Downloading Postman..."
wget https://dl.pstmn.io/download/latest/linux64 -O /tmp/postman-linux-x64.tar.gz

# Extract tarball to /opt directory
echo "Extracting Postman..."
sudo tar -xzf /tmp/postman-linux-x64.tar.gz -C /opt

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

# Verify installation
echo "Verifying installation..."
if command -v postman --version >/dev/null 2>&1; then
    echo "Postman is installed successfully."
else
    echo "Postman installation failed."
fi
