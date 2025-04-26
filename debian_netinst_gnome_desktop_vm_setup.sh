#!/bin/bash
# this script intended for virtual machine desktop setup

set -e

sudo test || true

start_time=$(date +%s)

exec > >(tee -a "logfile.log") 2>&1

bash debian/clean_repo.sh

sudo apt update && sudo apt install -y --no-install-suggests --no-install-recommends \
  gnome-session gdm3 gnome-terminal spice-vdagent firefox-esr

bash gnome/gnome_terminal_enable_bright_colors.sh
bash gnome/gdm3_enable_autologin.sh
bash disable_grub_timeout.sh
bash gnome/gsettings_host.sh
bash gnome/gsettings_guest.sh

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "debian gnome minimal virtual machine setup has been successfully completed in $execution_time seconds."
