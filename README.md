# Welcome!

To get started, make sure you're signed into a free GitHub account, then click the green "Use this Template" button near the top right, then click "Open in a Codespace". Once that finishes, you should see this same file after a short delay. Once you're at this point, you can follow the steps below.

## First Use

Follow these steps to set up your desktop, only do this **the first time**:

1. Click into the terminal box in the bottom half of the screen
2. When you see a block cursor, type `chmod +x setup.sh` and press enter, if it doesn't work, check that you typed it correctly.
3. Then type `./setup.sh` and press enter.
4. Wait for the setup to complete, this may take a long time. **Try not to close the tab or your device** while the setup runs.

Once everything is ready, a tab should open which should launch your VNC viewer. **You will likely get a "Popup Blocked" error** in this case, click the Popup Blocked text and select allow popups, then reload the page.

## Subsequent Uses

To access your desktop without creating a new codespace every time, visit [github.com/codespaces](https://github.com/codespaces) and click to launch your existing one. Do **not** click the "Use this emplate" button again. Once you are back in, follow these steps to start your desktop:

1. Click into the terminal box in the bottom half of the screen
2. When you see a block cursor, type `./start.sh` and press enter, if it doesn't work, check that you typed it correctly.

## Troubleshooting

### Q: I closed the tab that popped up, or it didn't open correctly the first time!
If the popup was blocked or you closed the tab, allow popups and follow this solution:

A: Type `./open.sh` in the terminal, and if that doesn't work try these steps:
1. Navigate to the "Ports" tab next to the "Terminal" tab
2. In the first "Port" column, look for port `1234` and follow it to the "Forwarded Address" column
3. Click the 🌐 Globe icon to open it in your browser
4. If it shows an error, reload until it works.

### Q: It says "Failed to Connect to Server" or something about being unable to handle the request
A: Wait a few seconds and try again or reload

### Q: I'm having other issues
A: Try resetting your codespace, note that this will delete all files and user data stored. Follow the steps below to try that:
1. Press <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> and type "Rebuild"
2. Select the "Full Rebuild Container" option by pressing <kbd>Enter</kbd>, using arrow keys if needed to select it.

## Drawbacks

- You are limited in the amount of time that this can be used, as well as the amount of storage space you can take up. Check [here](https://github.com/settings/billing/summary#:~:text=%240.00-,Codespaces,-Included%20quotas%20reset) for more information and your current use amount.
- While the internet speed in this browser is very fast, the connection speed might not be. Many games might be unplayable. To reduce the effects of this, scale down the chrome browser window.
- There is no sound available.
- Certain shortcuts like <kbd>Ctrl</kbd>+<kbd>w</kbd> may be overtaken by your browser and do unexpected things.