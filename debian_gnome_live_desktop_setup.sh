#!/bin/bash

set -e

start_time=$(date +%s)

bash debian/clean_repo.sh
bash gnome/gsettings_host.sh
bash firefox/debloat_firefox.sh
bash debian/debloat_debian_live.sh

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "debian_live_debloat has been completed in $execution_time seconds."
