#!/bin/bash

set -e

# check debian
# give exit code

echo "commenting out deb_src..."

# Check if backup file already exists
if grep -qE '^\s*#.*deb-src' /etc/apt/sources.list; then
  echo "Already deb-src lines have been commented out in /etc/apt/sources.list."
  exit
fi

# Backup the original sources.list file
sudo cp -i /etc/apt/sources.list /etc/apt/sources.list.bak

# Comment out all deb-src lines
sudo sed -i 's/^\(deb-src.*\)$/#\1/' /etc/apt/sources.list

echo "All deb-src lines have been commented out in /etc/apt/sources.list."
