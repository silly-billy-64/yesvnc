import inquirer from "inquirer";
import { Chalk } from "chalk";
import apps from "./apps";
import { exec } from "child_process";
import util from "util"
import fs from "fs"
import path from "path"
import { hostname, homedir } from "os";

// const hostname = () => "codespaces-skibbidy-toilet"

const asyncExec = util.promisify(exec)
const chalk = new Chalk();

const space = await getStorage();
const choices = [];

initApps()
askForApps()

function initApps() {
    fs.writeFileSync("/tmp/yesInstaller", "cd /tmp && mkdir installs && cd installs\n", { flag: 'w' }, (error) => {
        if (error) {
            console.error(error);
        }
    })


    for (const categoryId in apps) {
        const appCategory = apps[categoryId];
        choices.push(new inquirer.Separator(`-- ${appCategory.name} --`));
        appCategory.apps.forEach(app => {
            if (!app.tags.includes("nonYesVNC") || !hostname().includes("codespaces")) {
                choices.push({
                    name: app.size > space ? chalk.red(app.name) : (app.size !== 0 ? app.name + ` | ${app.desc} (${formatStorage(app.size)}${app.tags.includes("grows") ? "+" : ""})` : app.name),
                    value: app,
                    checked: app.tags?.includes("default")
                })
            }
        })
    }
}

function askForApps() {
    inquirer.prompt([
        {
            type: "checkbox",
            name: "selectedApps",
            message: `What would you like to install? \n ${formatStorage(space)} remaining`,
            loop: false,
            choices
        }
    ]).then(answer => {
        if (answer.selectedApps.length == 0) {
            console.log("No apps selected, doing nothing.")
            process.exit(0)
        }
        answer.selectedApps.forEach(app => {
            fs.appendFileSync("/tmp/yesInstaller", `# Installing ${app.name}\ncd /tmp/installs\n` + app.installScript + "\n")
        })
        fs.appendFileSync("/tmp/yesInstaller", `cd /tmp && rm -rf ./installs`)
    });
}




async function getStorage() {
    const { stdout, error } = await asyncExec('df -k .');
    if (error) return console.error(`An error has occurred: ${error.message}`);
    const bytes = parseInt(stdout.split('\n')[1].split(/\s+/)[3], 10) * 1024;

    return bytes
}

function formatStorage(bytes) {
    if (bytes === 0) return '0 Bytes';

    const k = 1024;
    const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));

    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i]
}
