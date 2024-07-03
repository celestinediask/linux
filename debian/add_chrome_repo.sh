#! /bin/bash

sudo test

wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo tee /etc/apt/trusted.gpg.d/google.asc >/dev/null

sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
