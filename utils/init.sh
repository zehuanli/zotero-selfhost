#!/bin/bash

sudo apt update
sudo apt install -y p7zip-full zip unzip docker-compose

# Install Node.js 14
curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs
