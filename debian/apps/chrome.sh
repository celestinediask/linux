add_repo_chrome() {
	echo "Adding google-chrome repo"
	wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo tee /etc/apt/trusted.gpg.d/google.asc >/dev/null
	sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
	echo "chrome repo added"
}

install_chrome_manual() {
	wget -P /tmp https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo apt install -y /tmp/google-chrome-stable_current_amd64.deb
	sudo rm /tmp/google-chrome-stable_current_amd64.deb
	echo "chrome installed"
}
