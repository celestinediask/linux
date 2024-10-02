#!/bin/bash

set -e

URL="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"

sudo test || true

echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections

wget $URL -O vscode.deb

sudo apt install ./vscode.deb

rm vscode.deb

echo "vscode has been successfully installed."
