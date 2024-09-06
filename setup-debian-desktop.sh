#! bin/sh

set -e

# nautilus items count show
# gnome-text-editor disable restore

# Loop through each file found in the current directory and its subdirectories
find . -type f -name '*.sh' | while read -r file; do
    # Source the file
    source "$file"
done


check_os
check_root
comment_out_deb_src
fix_wifi
gnome_settings_host

# install packages
sudo apt install vim mpv eog gnome-text-editor gnome-disk-utility gnome-system-monitor nautilus

# chrome

# firefox

# import config
cp -i config/vimrc ~/



