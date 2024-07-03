# shell script to install vscode in debian system

wget -P /tmp https://code.visualstudio.com/sha/download?build=insider&os=linux-deb-x64

sudo apt install /tmp/code-insiders_*_amd64.deb
