#!/bin/bash

sudo test || true

# Path to the file containing the list of packages
PACKAGE_LIST="debian/packages_bloat.txt"

# Check if the file exists
if [[ ! -f "$PACKAGE_LIST" ]]; then
  echo "File $PACKAGE_LIST not found!"
  exit 1
fi

# Read the file line by line and remove each package
while read -r package; do
  # Skip empty lines
  if [[ -z "$package" ]]; then
    continue
  fi

  echo "Removing package: $package"
  sudo apt-get remove --purge -y "$package"
done < "$PACKAGE_LIST"

# Clean up any unused dependencies
sudo apt-get autoremove -y
sudo apt-get autoclean -y

echo "Package removal complete."
