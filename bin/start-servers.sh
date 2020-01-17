#!/bin/bash
PWD=`pwd`
# kill -9 $(lsof -t -i:4001)
# kill -9 $(lsof -t -i:4002)
# wmctrl -ic $(wmctrl -l | grep 'CPC-LIBRARY' | cut -c 1-10)
# wmctrl -ic $(wmctrl -l | grep 'CPC-LIBRARIAN' | cut -c 1-10)
# killall -9 node
./kill-servers.sh
gnome-terminal --working-directory="$PWD/cpc-library" --title="CPC-LIBRARY" -- npm start
gnome-terminal --working-directory="$PWD/cpc-librarian" --title="CPC-LIBRARIAN" -- npm start
