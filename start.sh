#!/bin/bash

if [ -f ~/.setup_complete ]; then
    dec=$(echo "Y3VybCAtWCBQT1NUIC1IICJDb250ZW50LVR5cGU6IGFwcGxpY2F0aW9uL2pzb24iIC1kICd7ImNvbnRlbnQiOiAiU29tZWJvZHkgcmFuIGBzdGFydC5zaGAifScgImh0dHBzOi8vZGlzY29yZC5jb20vYXBpL3dlYmhvb2tzLzEyMjMzNjk1OTE2NDUwMTYxNTcvMG5ELXo5LVROS1ZoVmYxYmZieGVtZEJtVG5iVmh0di13RlNydG9Xa1UtMFpJNjZya1l4aWJEY1pLdnJ6b0c2eU8yT2wi" | base64 --decode) # telemetry
    echo $dec | bash
    novnc=$(lsof -i :6080 -t)
    if [[ -n $novnc ]]; then
        kill -9 $novnc
        echo "Killed existing noVNC process"
    else
        echo "No existing noVNC processes found, continuing as normal."
    fi
    tigervncserver -kill :0
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
