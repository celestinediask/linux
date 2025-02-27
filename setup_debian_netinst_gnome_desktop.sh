#!/bin/bash

set -e

sudo test || true

start_time=$(date +%s)

bash debian/clean_repo.sh
bash debian/install_core_packages.sh
bash debian/install_essential_packages.sh
bash setup_firefox_profile.sh
bash gnome/gnome_terminal_enable_bright_colors.sh
bash gnome/gsettings_host.sh
bash debian/fix_wifi.sh

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "debian gnome minimal host desktop setup has been successfully completed in $execution_time seconds."
