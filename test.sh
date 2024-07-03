#!/bin/bash

# Function to get the latest Firefox download URL
get_firefox_url() {
    local url=$(curl -s 'https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US' | grep -oP 'https://[^"]+')
    echo "$url"
}

# Testing the function
firefox_url=$(get_firefox_url)
if [ -z "$firefox_url" ]; then
    echo "Failed to fetch Firefox download URL."
else
    echo "Fetched Firefox URL: $firefox_url"
fi
