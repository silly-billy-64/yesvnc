#!/bin/bash

if [ -f ~/.setup_complete ]; then
    echo "Checking for updates..."
    ~/.bun/bin/bun updater/index.js
    if [ $? -eq 0 ]; then
        echo "=== Starting update ==="
        git fetch --all
        git reset --hard HEAD
        git clean -fd
        git remote add origin https://github.com/silly-billy-64/yesvnc
        git pull origin main
        chmod +x setup.sh
        rm -f ~/.setup_complete
        NO_AUTOSTART=1 ./setup.sh
    fi

    ./stop.sh
    sleep 0.5

    # echo "=== VNC is starting... ==="
    # echo "If this is the first time you are using this, you will need to create a VNC password."
    # echo "Make it something simple like \"password\" since nobody else can access this anyway."
    # echo "When asked about a view-only password, answer n for no."
    # echo "=========================="
    tigervncserver -xstartup "openbox-session" -geometry="1920x1080" :0 -SecurityTypes None --I-KNOW-THIS-IS-INSECURE # No, it's not (the page is only accessible with your Github token)
    noVNC/utils/novnc_proxy &
    ./open.sh
else
    echo "You haven't ran the setup script yet, or it failed. Please run ./setup.sh first."
    exit
fi
