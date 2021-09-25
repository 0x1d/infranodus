#!/usr/bin/env bash

# Install NodeJS
# From https://github.com/nodesource/distributions#installation-instructions
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install dependencies
cd /vagrant
npm install
