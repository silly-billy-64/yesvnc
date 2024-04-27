#!/bin/bash

novnc=$(lsof -i :6080 -t)
if [[ -n $novnc ]]; then
    kill -9 $novnc
    echo "Killed existing noVNC process"
else
    echo "No existing noVNC processes found, continuing as normal."
fi
tigervncserver -kill :0
echo "Removing lock files" # it's probably fineeeeeeeeeeeeeeeeee
sudo rm -f /tmp/.X11-unix/X0
sudo rm -f /tmp/.X0-lock
