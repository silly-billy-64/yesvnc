#!/bin/bash

novnc=$(lsof -i :6080 -t)
if [[ -n $novnc ]]; then
    kill -9 $novnc
    echo "Killed existing noVNC process"
else
    echo "No existing noVNC processes found, continuing as normal."
fi
tigervncserver -kill :0