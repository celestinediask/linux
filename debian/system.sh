# Check if OS is Debian-based
check_os() {
	echo "checking if OS is debian based..."
	if ! grep -q "^ID=debian" /etc/os-release; then
		echo "This script is intended for Debian-based distributions only. Exiting."
		exit 1
	fi
}

# Check if running with root privilage
check_root() {
	echo "checking root privilage..."
	if [ "$EUID" -ne 0 ]; then
		echo "Error: This script must be run as root!" >&2
		exit 1
	fi
}

comment_out_deb_src() {
	echo "running: commenting out deb_src..."
    # Check if backup file already exists
    if grep -qE '^\s*#.*deb-src' /etc/apt/sources.list; then
        echo "Already deb-src lines have been commented out in /etc/apt/sources.list."
        return
    fi

    # Backup the original sources.list file
    cp -i /etc/apt/sources.list /etc/apt/sources.list.bak

    # Comment out all deb-src lines
    sed -i 's/^\(deb-src.*\)$/#\1/' /etc/apt/sources.list

    echo "All deb-src lines have been commented out in /etc/apt/sources.list."
}

update_system() {
	echo "updating and upgrading system..."
	sudo apt update
	sudo apt upgrade
}

fix_wifi() {
	echo "fixing wifi..."
	sudo mv -i /etc/network/interfaces ~/interfaces.bak
	sudo systemctl restart wpa_supplicant.service
	sudo systemctl restart NetworkManager
}
