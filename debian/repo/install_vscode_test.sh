#!/bin/bash

set -e

start_time=$(date +%s)

URL="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"

sudo test || true

echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections

wget $URL -O vscode.deb

sudo apt install ./vscode.deb

rm vscode.deb

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "completed in $execution_time seconds"

echo "vscode has been successfully installed."
