#!/bin/bash

echo "Installing Dokku"
# for debian systems, installs Dokku via apt-get
wget https://raw.githubusercontent.com/dokku/dokku/v0.24.1/bootstrap.sh;
sudo DOKKU_TAG=v0.24.1 bash bootstrap.sh