import fs from 'fs'
import inquirer from 'inquirer'

const filePath = `${process.env.HOME}/.yesvnc_last_sha`

if (!fs.existsSync(filePath)) {
    fs.writeFileSync(filePath, "")
}

const oldSha = fs.readFileSync(filePath).toString().trim()

// console.log("Old SHA: " + oldSha)
fetch("https://api.github.com/repos/silly-billy-64/yesvnc/commits/main").then((res) => {
    res.json().then((data) => {
        const sha = data.sha
        if (oldSha === "") {
            fs.writeFileSync(filePath, sha)
            process.exit(1)
        }
        if (sha !== oldSha) {
            // console.log("New SHA: " + sha)
            inquirer.prompt([{name: "confirmed", type: "confirm", message: "A new update is avilable for yesvnc! Would you like to update now? You will lose your chrome data, but the update may introduce new features and fixes." }]).then((answer) => {
                if (answer.confirmed == false) {
                    console.log("Skipping this update, please consider updating next time!")
                    process.exit(1)
                } else {
                    console.log("Updating... please wait. yesVNC will automatically launch when the update is complete.")
                    fs.writeFileSync(filePath, sha)
                    process.exit(0)
                }
            });
        } else {
            console.log("No updates found, continuing...")
            process.exit(1)
        }
    })
})
