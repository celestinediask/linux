#! /bin/bash

set -e

vpn_interface=tun0
network_interface=enp1s0

# Default policies
sudo ufw default deny incoming
sudo ufw default deny outgoing

# Openvpn interface
sudo ufw allow in on $vpn_interface
sudo ufw allow out on $vpn_interface

# Openvpn
sudo ufw allow in on $network_interface from any port 1194
sudo ufw allow out on $network_interface to any port 1194

sudo ufw enable
sudo ufw status verbose
