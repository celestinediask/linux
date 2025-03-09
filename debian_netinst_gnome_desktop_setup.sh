#! /bin/bash

set -e

start_time=$(date +%s)

packages_core="debian/packages_core.txt"
packages_essential="debian/packages_essential.txt"
packages=$(cat $packages_core; echo; cat $packages_essential)

bash debian/clean_repo.sh
sudo apt update
sudo apt install -y --no-install-suggests --no-install-recommends $packages
bash firefox_profile_setup.sh
bash gnome/gsettings_host.sh
bash debian/fix_wifi.sh


# dock setup
sudo apt install gnome-shell-extension-dash-to-panel
gnome-extensions list
gnome-extensions enable dash-to-panel@jderose9.github.com
# disable overview on startup

# setup fonts
    
end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "debian_netinst_setup has been successfully completed in $execution_time seconds."
