#!/bin/bash

set -e

start_time=$(date +%s)

sudo apt update

sudo apt install -y --no-install-suggests --no-install-recommends gnome-session gdm3 gnome-console network-manager gnome-keyring wpasupplicant

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "successfully installed core packages for debian in $execution_time seconds."
