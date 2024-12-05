#!/bin/bash

set -e

sudo apt update

sudo apt install -y gnome-session --no-install-suggests --no-install-recommends

sudo apt install -y gdm3 gnome-terminal network-manager gnome-keyring wpasupplicant
