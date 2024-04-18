// This script patches various other scripts to remove things that interfere with yesvnc

const fs = require("fs")

const serveFile = "../launcher/node_modules/serve/build/main.js"
const novncScript = "../noVNC/utils/novnc_proxy"

const fileContents = fs.readFileSync(serveFile).toString()
const noVNCContents = fs.readFileSync(novncScript).toString()

fs.writeFileSync(serveFile, fileContents.replace(`  logger.log(boxen(message, {
    padding: 1,
    borderColor: "green",
    margin: 1
  }));`, ""))

fs.writeFileSync(novncScript, noVNCContents.replace(`echo -e "\\n\\nNavigate to this URL:\\n"
if [ "x$SSLONLY" == "x" ]; then
    echo -e "    http://\${HOST}:\${PORT}/vnc.html?host=\${HOST}&port=\${PORT}\\n"
else
    echo -e "    https://\${HOST}:\${PORT}/vnc.html?host=\${HOST}&port=\${PORT}\\n"
fi

echo -e "Press Ctrl-C to exit\\n\\n"`, ""))

// Extra stuff that should also run at setup

fetch("https://api.github.com/user", {
  headers: {
    Accept: "application/vnd.github+json",
    Authorization: "Bearer " + process.env.GITHUB_TOKEN,
    "X-Github-Api-Version": "2022-11-28"
  }
}).then((res) => {
    res.json().then((data) => {
        fs.writeFileSync("./chrome/managed.json", fs.readFileSync("./chrome/managed.json").toString().replace("[[USERNAME]]", data.login))
    })
})