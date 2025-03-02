#!/bin/bash

set -e

start_time=$(date +%s)

PACKAGE_LIST="../gnome/core_packages.txt"

# Check if the package list file exists
if [ ! -f "$PACKAGE_LIST" ]; then
  echo "Error: $PACKAGE_LIST not found!"
  exit 1
fi

sudo apt update

sudo apt install -y --no-install-suggests --no-install-recommends $(cat "PACKAGE_LIST")

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "successfully installed core packages for debian in $execution_time seconds."
