#!/bin/bash
cd /workspaces/yesvnc/installer
~/.bun/bin/bun index.js
wait
chmod +x /tmp/yesInstaller
/tmp/yesInstaller
