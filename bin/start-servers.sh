#!/bin/bash
PWD=`pwd`
./bin/kill-servers.sh
sudo systemctl start mongod
sudo systemctl status mongod
gnome-terminal --working-directory="$PWD/cpc-library" --title="CPC-LIBRARY" -- npm start
gnome-terminal --working-directory="$PWD/cpc-librarian" --title="CPC-LIBRARIAN" -- npm start
