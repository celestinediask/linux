#! /bin/bash

set -e

sudo test || true

start_time=$(date +%s)

# Check if Git is installed
if ! command -v git &> /dev/null; then
  echo "git is not installed. git is required to run this script. Exiting."
  exit 0
fi

bash gnome/gsettings_host.sh
bash gnome/gnome_terminal_enable_bright_colors.sh
bash debian/clean_repo.sh
bash debian/create_template.sh
bash setup_firefox_profile.sh
bash debian/debloat.sh

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "debian gnome live desktop setup has been successfully completed in $execution_time seconds."
