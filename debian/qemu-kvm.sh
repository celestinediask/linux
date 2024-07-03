# Initial setup for QEMU/KVM debian VM

# enable host to guest copy & paste feature (reboot required)
enable_copy_paste_feature() {
	sudo apt install spice-vdagent
	sudo systemctl start spice-vdagent
}


disable_automatic_screenlock() {
	gsettings set org.gnome.desktop.screensaver lock-enabled false
}

disable_automatic_screen_blank() {
	gsettings set org.gnome.desktop.session idle-delay 0
}

# Function to enable autologin for current user in GDM
enable_autologin() {
    # Get current username
    CURRENT_USER=$(whoami)

    # Set GDM configuration file
    GDM_CONFIG_FILE="/etc/gdm3/daemon.conf"

    # Enable autologin for the current user
    sudo sed -i 's/# *\(AutomaticLoginEnable\).*/\1 = true/' $GDM_CONFIG_FILE
    sudo sed -i "s/# *\(AutomaticLogin\).*/\1 = $CURRENT_USER/" $GDM_CONFIG_FILE

    echo "Autologin enabled for $CURRENT_USER."
}

main() {
	enable_autologin
	enable_copy_paste_feature
	disable_automatic_screenlock
#	disable_automatic_screen_blank
}

main
