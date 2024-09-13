gnome_settings_host() {
	echo "setting gnome settings for host machine..."
	# set dark theme
	gsettings set org.gnome.desktop.interface color-scheme prefer-dark
	gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
	gsettings set org.gnome.desktop.interface gtk-theme 'HighContrastInverse' # for legacy apps

	# set icon theme
	gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'
		
	# disable file history
	gsettings set org.gnome.desktop.privacy remember-recent-files false

	# enable tap to click
	gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

	# show battery percentage
	gsettings set org.gnome.desktop.interface show-battery-percentage true

	# set favorite apps
	gsettings set org.gnome.shell favorite-apps "['kitty.desktop', 'org.gnome.Nautilus.desktop', 'firefox.desktop', 'google-chrome.desktop']"

	# set background color
	gsettings set org.gnome.desktop.background primary-color '#000000'

	# enable over amplification
	gsettings set org.gnome.desktop.sound allow-volume-above-100-percent 'true'
}

gnome_settings_guest() {
	echo "setting gnome settings for guest machine..."
	
	# disable automatic screenlock
	gsettings set org.gnome.desktop.screensaver lock-enabled false

	# disable automatic screen blank
	gsettings set org.gnome.desktop.session idle-delay 0
}
