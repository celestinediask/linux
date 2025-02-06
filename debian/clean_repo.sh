#!/bin/bash

set -e

file="/etc/apt/sources.list"

# Check if backup file already exist.
if [ -e "$file.bak" ]; then
  echo "Backup file: $file.bak already exists. Skipping..."
  exit 0
fi

# Backup the original file.
sudo cp -i $file $file.bak

# remove deb-src repo
sudo sed -i '/deb-src/d' $file

# remove backports repo
sudo sed -i '/backports/d' $file

# remove commented lines
sudo sed -i '/^#/d' $file

# remove empty lines
sudo sed -i '/^$/d' $file

echo "Repo is cleaned."
