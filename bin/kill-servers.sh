#!/bin/bash
kill -9 $(lsof -t -i:4001)
kill -9 $(lsof -t -i:4002)
wmctrl -ic $(wmctrl -l | grep 'CPC-LIBRARY' | cut -c 1-10)
wmctrl -ic $(wmctrl -l | grep 'CPC-LIBRARIAN' | cut -c 1-10)
killall -9 node
