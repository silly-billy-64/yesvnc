pid=$(lsof -i :1234 -t)
if [[ -n $pid ]]; then
    kill -9 $pid
fi
cd launcher
~/.bun/bin/bun x serve --listen 1234 --no-clipboard --no-request-logging --cors &
xdg-open https://$(jq -r ".CODESPACE_NAME" /workspaces/.codespaces/shared/environment-variables.json)-1234.app.github.dev
sleep 1
echo " "
echo "   ┌──────────────────────────────────────────────────┐"
echo "   │ yesVNC should now be running.                    │"
echo "   │ If nothing opened, make sure popups are allowed  │"
echo "   │ To re-open the tab, type \"open\" and press enter  │"
echo "   │ To restart yesVNC, type \"start\" and press enter  │"
echo "   │ To stop yesVNC, type \"stop\" and press enter      │"
echo "   └──────────────────────────────────────────────────┘"
echo " "