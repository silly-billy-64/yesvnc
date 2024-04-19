#!/bin/bash

# Check if the startup already finished
if [ -f ~/.setup_complete ]; then
    echo "You've already ran the setup script once, please run ./start.sh instead."
    echo "If you want to force setup to run again (which can cause problems), run rm ~/.setup_complete then try again."
    exit
fi

echo "=== Starting Setup ==="
echo "=== Cloning VNC Proxy ==="
git clone https://github.com/novnc/noVNC
cp ./config/novnc_vnc.html noVNC/index.html
rm -rf noVNC/.git
echo "/usr/bin/google-chrome-stable --no-sandbox --disable-dev-shm-usage" > x-www-browser
sudo mv x-www-browser /usr/local/bin
sudo chmod +x /usr/local/bin/x-www-browser
echo "=== Updating Packages ==="
sudo apt update
sudo apt upgrade -y
echo "=== Installing Bun ==="
curl -fsSL https://bun.sh/install | bash
source ~/.bashrc
cd launcher
~/.bun/bin/bun i
cd ..
cd updater
~/.bun/bin/bun i
cd ..
echo "=== Installing Packages ==="
sudo apt install -y tigervnc-standalone-server openbox tint2 feh pcmanfm xdg-utils
echo "=== Installing Google Chrome ==="
wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" --output-document chrome.deb
sudo apt install -y ./chrome.deb
rm chrome.deb
echo "=== Setting up Google Chrome ==="
cd config
cp google-chrome.desktop ~/.google-chrome.desktop
cd ~/.config/
rm -rf google-chrome
mkdir -p ~/.config/google-chrome/Default
cd google-chrome/Default
unzip /workspaces/yesvnc/config/chrome.zip
cd /workspaces/yesvnc/config
~/.bun/bin/bun patcher.js
sudo mkdir -p /etc/opt/chrome/policies/recommended/
sudo mkdir -p /etc/opt/chrome/policies/managed/
sudo cp /tmp/managed.json /etc/opt/chrome/policies/managed/managed_policies.json
sudo cp chrome/recommended.json /etc/opt/chrome/policies/recommended/recommended_policies.json
sudo cp /workspaces/yesvnc/config/chrome/extension_update.xml /opt/google/chrome/extension_update.xml
sudo cp /workspaces/yesvnc/config/chrome/internal.crx /opt/google/chrome/
sudo chown vscode /opt/google/chrome/extension_update.xml
sudo chown vscode /opt/google/chrome/internal.crx
cd /workspaces/yesvnc
mkdir -p ~/Desktop
mkdir -p ~/Documents
mkdir -p ~/Downloads
cp images/wallpaper.png ~/Desktop/wallpaper.png
echo "=== Configuring Statup Files ==="
mkdir -p ~/.config/openbox/
touch ~/.config/openbox/autostart
chmod +x ~/.config/openbox/autostart
echo "feh --bg-fill ~/Desktop/wallpaper.png & tint2 & /usr/bin/google-chrome-stable --no-sandbox --disable-dev-shm-usage" > ~/.config/openbox/autostart
cp ./config/openbox.xml ~/.config/openbox/rc.xml
mkdir -p ~/.config/tint2/
cp ./config/tint2rc ~/.config/tint2/tint2rc
chmod +x start.sh
chmod +x open.sh
chmod +x stop.sh
echo "$(pwd)/start.sh" > start
echo "$(pwd)/open.sh" > open
echo "$(pwd)/stop.sh" > stop
chmod +x start
chmod +x open
chmod +x stop
sudo mv start /usr/local/bin
sudo mv open /usr/local/bin
sudo mv stop /usr/local/bin
echo "=== Setup complete, starting now ==="
touch ~/.setup_complete
if [ -z "${NO_AUTOSTART}" ]; then
    ./start.sh # running normally
else
    exit # running in a prebuild
fi