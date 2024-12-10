#!/bin/bash

# Global variable for the VPN IP
VPN_IP="149.40.62.25"  # Replace with your actual VPN IP
WAIT=10

# Function to get the current public IP
get_public_ip() {
    curl -s ifconfig.me
}

# Function to extract the first three octets from an IP
extract_ip_prefix() {
    local ip=$1
    echo "$ip" | cut -d '.' -f1-3
}

# Function to check IP leak
check_ip_leak() {
    # Get the current public IP
    current_ip=$(get_public_ip)

    # Check if current_ip is empty
    if [ -z "$current_ip" ]; then
        echo "Error: Unable to retrieve current public IP."
        return
    fi

    # Display the current IP and VPN IP
    echo "Current IP: $current_ip"
    echo "Expected VPN IP: $VPN_IP"

    # Extract the first three octets of both the current IP and the VPN IP
    current_ip_prefix=$(extract_ip_prefix "$current_ip")
    vpn_ip_prefix=$(extract_ip_prefix "$VPN_IP")

    # Compare the current IP with the expected VPN IP
    if [ "$current_ip_prefix" != "$vpn_ip_prefix" ]; then
        echo "IP Leak detected! Your real IP ($current_ip) is exposed. Exiting."
        exit 0
    else
        echo "No IP leak detected. You are using the VPN correctly."
    fi
}

# Function to check DNS leak (by querying OpenDNS)
check_dns_leak() {
    # Query OpenDNS to get the public IP the DNS server sees
    dns_ip=$(dig @resolver1.opendns.com myip.opendns.com +short)
    echo "DNS server sees IP: $dns_ip"

    # Check if dns_ip is empty
    if [ -z "$dns_ip" ]; then
        echo "Error: Unable to retrieve DNS IP. DNS leak check failed."
        return
    fi

    # Extract the first three octets of both the DNS IP and the VPN IP
    dns_ip_prefix=$(extract_ip_prefix "$dns_ip")
    vpn_ip_prefix=$(extract_ip_prefix "$VPN_IP")

    # Check if DNS IP matches VPN IP
    if [ "$dns_ip_prefix" != "$vpn_ip_prefix" ]; then
        echo "Warning: DNS Leak detected! DNS server sees a different IP ($dns_ip). Exiting"
        exit 0
    else
        echo "No DNS leak detected. DNS server sees the VPN IP."
    fi
}

# Function to check for IPv6 leak
check_ipv6_leak() {
    ipv6=$(curl -6 -s ifconfig.me)
    if [ -n "$ipv6" ]; then
        echo "IPv6 Leak detected! Public IPv6 address: $ipv6. Exiting."
	exit 0
    else
        echo "No IPv6 leak detected."
    fi
}

echo "Startomg IP leak test..."

# Check if VPN_IP is empty
if [ -z "$VPN_IP" ]; then
    echo "Error: VPN_IP is empty! Please set your VPN IP in the script."
    exit 1
fi

# Continuous check loop
while true; do

    check_ip_leak

    check_dns_leak

    check_ipv6_leak

    echo "Waiting for $WAIT seconds before the next check..."
    echo -n "=================================================="
    sleep "$WAIT"
    echo

done
