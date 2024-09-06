add_repo_vscode() {
	echo "Adding vscode repo..."
	sudo apt install -y wget gpg #gnupg
	# curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
	sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/keyrings/microsoft-archive-keyring.gpg
	sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
	sudo apt install apt-transport-https
	echo "vscode repo added"
}

install_vscode_manual() {
	sudo apt install wget -y
	wget -O /tmp/code-insiders.deb "https://code.visualstudio.com/sha/download?build=insider&os=linux-deb-x64"
	sudo apt install /tmp/code-insiders.deb
}
