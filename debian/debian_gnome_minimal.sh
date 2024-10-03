#!/bin/bash

set -e

start_time=$(date +%s)

./comment_deb_src.sh

sudo apt update

sudo apt install gnome-session --no-install-recommends --no-install-suggests

sudo apt install gdm3 gnome-terminal

end_time=$(date +%s)

execution_time=$((end_time - start_time))

echo "debian gnome minimal env has been successfully completed in $execution_time seconds."