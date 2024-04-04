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
echo "firefox" > x-www-browser
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
echo "=== Installing Firefox ==="
if [ -f ~/.firefox_repo_added ]; then
echo "Skipped adding firefox repo, it was already added."
else
sudo install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla
touch ~/.firefox_repo_added
fi
sudo apt-get update && sudo apt-get install -y firefox
echo "=== Setting up Firefox ==="
cd ./config
rm -rf ~/.mozilla/firefox
mkdir -p ~/.mozilla/firefox
unzip firefox.zip
mv firefox/* ~/.mozilla/firefox
rm -rf firefox
cd ..
mkdir -p ~/Desktop
mkdir -p ~/Documents
mkdir -p ~/Downloads
cp images/wallpaper.png ~/Desktop/wallpaper.png
echo "=== Configuring Statup Files ==="
mkdir -p ~/.config/openbox/
touch ~/.config/openbox/autostart
chmod +x ~/.config/openbox/autostart
echo "feh --bg-fill ~/Desktop/wallpaper.png & tint2 & firefox" > ~/.config/openbox/autostart
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
cd config
~/.bun/bin/bun patcher.js
cd ..
echo "=== Setup complete, starting now ==="
touch ~/.setup_complete
if [ -z "${NO_AUTOSTART}" ]; then
    ./start.sh # running normally
else
    exit # running in a prebuild
fi