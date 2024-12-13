#!/bin/bash

VPN_IP=""
WAIT=30

# Colors
MGN="\e[35m"
GRN="\033[0;32m"
RED="\033[0;31m"
YLW="\033[0;33m"
GRY="\033[1;30m"
RES="\033[0m"

check_curl_installed() {
    if ! command -v curl &> /dev/null; then
        echo "curl command not found. Exiting."
        exit 1
    fi
}

get_public_ip() {
    curl -s ifconfig.me
}

is_valid_ip() {
    local ip="$1"
    local regex="^([0-9]{1,3}\.){3}[0-9]{1,3}$"

    if [[ "$ip" =~ $regex ]]; then
        # IP format is correct, now check if each octet is between 0 and 255
        IFS='.' read -r -a octets <<< "$ip"

        for octet in "${octets[@]}"; do
            if ((octet < 0 || octet > 255)); then
                return 1  # Return false if any octet is out of range
            fi
        done

        return 0  # Return true if all checks passed
    else
        return 1  # Return false if the format is incorrect
    fi
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
        echo -e "\n${YLW}Warning: Unable to retrieve current public IP.${RES}"
        return
    fi

    if ! is_valid_ip "$current_ip"; then
        echo -e "${YLW}Warning: IP leak test failed.${RES} $current_ip"
        return
    fi

    # Extract the first three octets of both the current IP and the VPN IP
    current_ip_prefix=$(extract_ip_prefix "$current_ip")
    vpn_ip_prefix=$(extract_ip_prefix "$VPN_IP")

    # Compare the current IP with the expected VPN IP
    if [ "$current_ip_prefix" != "$vpn_ip_prefix" ]; then
        echo -e "\n${RED}IP Leak detected! Your real IP ($current_ip) is exposed.${RES} Exiting."
        exit 0
    else
        echo -en "\n${GRN}No IP leak detected. Current IP: $current_ip${RES}"
    fi
}

# Function to check DNS leak (by querying OpenDNS)
check_dns_leak() {
    # Query OpenDNS to get the public IP the DNS server sees
    dns_ip=$(dig @resolver1.opendns.com myip.opendns.com +short)

    # Check if dns_ip is empty
    if [ -z "$dns_ip" ]; then
        echo "Warning: Unable to retrieve DNS IP. DNS leak check failed."
        return
    fi

    if ! is_valid_ip "$dns_ip"; then
        echo -en "${YLW}Warning: DNS leak check failed:${RES} $dns_ip"
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
        echo -en "\n${GRN}No DNS leak detected. DNS server sees IP: $dns_ip${RES}"
    fi
}

# Function to check for IPv6 leak
check_ipv6_leak() {
    ipv6=$(curl -6 -s ifconfig.me) || true
    if [ -n "$ipv6" ]; then
        echo -en "${RED}IPv6 Leak detected! Public IPv6 address: $ipv6.${RES} Exiting."
	exit 0
    else
        echo -en "\n${GRN}No IPv6 leak detected.${RES}"
    fi
}

countdown() {
    local start=$WAIT
    echo
    for ((i=start; i>=0; i--)); do
        printf "\r${GRY}Waiting for ${MGN}%02d ${GRY}seconds before the next check...${RES}" "$i"
        sleep 1
    done
}



echo -n "Starting IP leak test..."

echo -en "\nFrequency: $WAIT seconds."

# Check if VPN_IP is empty
if [ -z "$VPN_IP" ]; then
    echo -e "${YLW}Error: VPN_IP is empty! Please set your VPN IP in the script.${RES}"
    exit 1
fi

if ! is_valid_ip "$VPN_IP"; then
    echo -e "${YLW}Invalid VPN IP EEEEEEEEE${RES}"
    exit 1
fi

check_curl_installed

while true; do

    check_ip_leak

    check_dns_leak

    check_ipv6_leak

    countdown

done



