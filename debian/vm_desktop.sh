#!/bin/bash
# this script intended for virtual machine desktop setup

set -e

sudo test || true

start_time=$(date +%s)

bash 001_comment_deb_src.sh

sudo apt update
sudo apt install -y gnome-session --no-install-suggests --no-install-recommends
sudo apt install -y gdm3 gnome-terminal spice-vdagent

bash 003_gnome_terminal_enable_bright_colors.sh

bash ../gdm3_disable_autologin.sh

bash ../gnome/gsettings_host.sh
bash ../gnome/gsettings_guest.sh

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "debian gnome minimal virtual machine setup has been successfully completed in $execution_time seconds."
