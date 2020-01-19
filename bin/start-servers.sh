#!/bin/bash

# Assumes execution from root directory of project
PWD=`pwd`

./bin/kill-servers.sh
sudo systemctl start mongod
sudo systemctl status mongod

APT_CACHE_POLICY=`apt-cache policy wmctrl | grep "Installed:"`

# Install wmctrl if not installed
if [[ "$APT_CACHE_POLICY" == *"(none)"* ]]
then
  echo "wmctrl NOT INSTALLED"
  sudo apt-get install wmctrl
else
  echo ""
fi

# Install all Ruby packages for main project
bundle install
# Install all NPM packages for cpc-library
gnome-terminal --working-directory="$PWD/cpc-library" --title="CPC-LIBRARY" -- npm install
# Install all NPM packages for cpc-librarian
gnome-terminal --working-directory="$PWD/cpc-librarian" --title="CPC-LIBRARIAN" -- npm install
# Start cpc-library server
gnome-terminal --working-directory="$PWD/cpc-library" --title="CPC-LIBRARY" -- npm start
# Start cpc-librarian server
gnome-terminal --working-directory="$PWD/cpc-librarian" --title="CPC-LIBRARIAN" -- npm start
