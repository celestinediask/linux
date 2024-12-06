#!/bin/bash
# this script intended for virtual machine desktop setup

set -e

sudo test || true

start_time=$(date +%s)

bash 001_comment_deb_src.sh 2>&1 | tee -a logfile.log

sudo apt update 2>&1 | tee -a logfile.log
sudo apt install -y gnome-session --no-install-suggests --no-install-recommends 2>&1 | tee -a logfile.log
sudo apt install -y gdm3 gnome-terminal spice-vdagent 2>&1 | tee -a logfile.log

bash 003_gnome_terminal_enable_bright_colors.sh 2>&1 | tee -a logfile.log

bash ../gdm3_enable_autologin.sh 2>&1 | tee -a logfile.log

bash ../gnome/gsettings_host.sh 2>&1 | tee -a logfile.log
bash ../gnome/gsettings_guest.sh 2>&1 | tee -a logfile.log

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "debian gnome minimal virtual machine setup has been successfully completed in $execution_time seconds." 2>&1 | tee -a logfile.log
