#!/bin/bash

get_firefox_url() {
    local url=$(curl -s 'https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US' | grep -oP 'https://[^"]+')
    echo "$url"
}

download_firefox() {
    local url=$1
    wget "$url"
}

install_firefox() {
    tar -xjf firefox.tar.bz2
    tar xjf firefox-*.tar.bz2
    sudo mv -i firefox /opt/
    sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox
    sudo wget https://raw.githubusercontent.com/mozilla/sumo-kb/main/install-firefox-linux/firefox.desktop -P /usr/local/share/applications
}

main() {
    local firefox_url=$(get_firefox_url)
    if [ -z "$firefox_url" ]; then
        echo "Failed to fetch Firefox download URL."
        exit 1
    fi

    download_firefox "$firefox_url"
    if [ $? -ne 0 ]; then
        echo "Failed to download Firefox."
        exit 1
    fi

    install_firefox
    if [ $? -ne 0 ]; then
        echo "Failed to install Firefox."
        exit 1
    fi

    echo "Firefox installation completed successfully."
}

main
