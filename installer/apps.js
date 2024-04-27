export default {
    "gaming": {
        name: "Gaming",
        apps: [
            {
                name: "Minecraft",
                desc: "Minecraft Launcher provided by Mojang",
                size: 185597952,
                tags: ["grows"],
                installScript: `wget https://launcher.mojang.com/download/Minecraft.deb && sudo apt install -y ./Minecraft.deb openjdk-17-jre`
            }, {
                name: "MultiMC",
                desc: "Alternate Minecraft Launcher",
                size: 68472012,
                tags: ["grows"],
                installScript: `wget https://files.multimc.org/downloads/multimc_1.6-1.deb && sudo apt install -y ./multimc_1.6-1.deb`
            }
        ]
    },
    "web": {
        name: "Web",
        apps: [
            {
                name: "Firefox",
                desc: "The Firefox web browser",
                size: 268435456,
                tags: ["grows"],
                installScript: `sudo install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla
sudo apt-get update && sudo apt-get install -y firefox`
            },
            {
                name: "Microsoft Edge",
                desc: "The Microsoft Edge web browser :stinky:",
                size: 618659840,
                tags: ["grows"],
                installScript: `wget https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_124.0.2478.51-1_amd64.deb && sudo apt install -y ./microsoft-edge-stable_124.0.2478.51-1_amd64.deb
sudo desktop-file-install --delete-original --set-key=Exec --set-value "/usr/bin/microsoft-edge-stable %U --no-sandbox  --disable-dev-shm-usage" /usr/share/applications/microsoft-edge.desktop`
            },
            {
                name: "Jellyfin Media Player",
                desc: "A desktop app to play content from a Jellyfin server",
                size: 42467328,
                tags: ["nonYesVNC"],
                installScript: `wget https://github.com/jellyfin/jellyfin-media-player/releases/download/v1.9.1/jellyfin-media-player_1.9.1-1_amd64-bookworm.deb && sudo apt install -y ./jellyfin-media-player_1.9.1-1_amd64-bookworm.deb`
            }
        ]
    },
    "social": {
        name: "Social",
        apps: [
            {
                name: "Discord",
                desc: "Discord client",
                size: 101046628,
                tags: ["default"],
                installScript: `wget "https://discord.com/api/download?platform=linux&format=deb" --output-document discord.deb && sudo apt install -y ./discord.deb
sudo desktop-file-install --delete-original --set-key=Exec --set-value "/usr/share/discord/Discord --no-sandbox" /usr/share/applications/discord.desktop`
            }
        ]
    },
    "management": {
        name: "Management",
        apps: [
            /* {
                name: "Polybar",
                desc: "A simple info-bar that will show you quick statistics about your machine",
                size: 2315000,
                tags: ["default"],
                installScript:  `sudo apt install -y polybar wmctrl slop
cd ~/.config
mkdir polybar && cd polybar
wget https://gist.githubusercontent.com/CAProductions/4b8eed35ec2207a58ce4a4e71b3b74ad/raw/2fb9dc3449f17534a92a032223efc188b3743a57/config.ini
mkdir scripts && cd scripts
wget https://raw.githubusercontent.com/uniquepointer/polywins/master/polywins.sh
chmod +x ./polywins.sh
cd ~/.config/openbox/
echo "polybar -c=~/.config/polybar/config.ini example &" >> autostart
polybar -c=~/.config/polybar/config.ini example` //https://raw.githubusercontent.com/polybar/polybar/master/doc/config.ini
            }, */
            {
                name: "gedit (text editor)",
                desc: "A general purpose text editor.",
                size: 1649000,
                tags: ["default"],
                installScript: "sudo apt install -y gedit"
            },
            {
                name: "GNOME Software",
                desc: "Install, view, and remove software.",
                size: 3191808,
                tags: ["default"],
                installScript: `sudo apt install -y gnome-software`
            },
            {
                name: "GNOME Extension Manager",
                desc: "Install extensions that offer additional functionality while using GNOME",
                size: 439296,
                tags: ["nonYesVNC"],
                installScript: "sudo apt install -y gnome-shell-extension-manager"
            },
            {
                name: "TigerVNC Server",
                desc: "Stream a virtual desktop (advanced users only!!)",
                size: 2843648,
                tags: ["nonYesVNC"],
                installScript: "sudo apt install -y tigervnc-standalone-server"
            }
        ]
    },
    "development": {
        name: "Programming (for advanced users)",
        apps: [
            {
                name: "VSCode",
                desc: "Powerful and feature rich code editor from Microsoft",
                size: 423624704,
                tags: ["grows"],
                installScript: `sudo apt install -y code`
            },
            {
                name: "NPM",
                desc: "Javascript package manager",
                size: 15728640,
                tags: ["grows"],
                installScript: "sudo apt install -y npm"
            },
            {
                name: "Node Version Manager",
                desc: "Install multiple versions of NodeJS",
                size: 0,
                tags: ["default"],
                installScript: "wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash"
            }
        ]
    },
    // "other": {
    //     name: "Other",
    //     apps: [
    //         {
    //             name: "Minecraft",
    //             desc: "Minecraft Launcher provided by Mojang",
    //             size: 185597952,
    //             tags: ["grows"],
    //             installScript: `wget https://launcher.mojang.com/download/Minecraft.deb && sudo apt install -y ./Minecraft.deb`
    //         }
    //     ]
    // }
}
