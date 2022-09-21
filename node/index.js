#!/usr/bin/env node

import chalk from "chalk";
import chalkAnimation from "chalk-animation";
import figlet from "figlet";
import gradient from "gradient-string";
import inquirer from "inquirer";
import { createSpinner } from "nanospinner";

let playerName;

const sleep = (ms = 2000) => new Promise((resolve) => setTimeout(resolve, ms));

async function welcome() {
    console.clear()
    const rainbowTitle = chalkAnimation.rainbow("Who Wants To Be A JavaScript Millionaire?\n");

    await sleep();
    rainbowTitle.stop();

    console.log(`
        ${chalk.bgBlue("HOW TO PLAY")}
        I am a process on your computer.    
        If you get any question wrong I will be ${chalk.bgRed("killed")}
        So get all the questions right...
    `)
}

await welcome()

async function askName() {
    const answers = await inquirer.prompt({
        name: "player_name",
        type: "input",
        message: "What is your name?",
        default() {
            return "Player"
        }
    })

    playerName = answers.player_name;
}

await askName()

async function question1() {
    const correct = "Nov 24th 1995"
    const answers = await inquirer.prompt({
        name: "question_1",
        type: "list",
        message: "JavaScript was created in 10 days then released on\n",
        choices: [
            "May 23rd, 1995",
            correct,
            "Dec 4th, 1995",
            "Dec 17th, 1996"
        ]
    })

    return handleAnswer(answers.question_1 === correct)
}

async function question2() {
    const correct = "Nov 24th 1995"
    const answers = await inquirer.prompt({
        name: "question_1",
        type: "list",
        message: "JavaScript was created in 10 days then released on\n",
        choices: [
            "May 23rd, 1995",
            correct,
            "Dec 4th, 1995",
            "Dec 17th, 1996"
        ]
    })

    return handleAnswer(answers.question_1 === correct)
}

async function handleAnswer(isCorrect) {
    const spinner = createSpinner("Checking answer...").start()
    await sleep()

    if (isCorrect) {
        spinner.success({ text: `Nice work ${playerName}.` })
    } else {
        spinner.error({ text: `💀💀💀 Game over, you lose ${playerName}!` })
        process.exit(1)
    }
}

await question1()

function winner() {
    console.clear()
    const message = `Congrats , ${playerName} !\n $ 1 , 0 0 0 , 0 0 0`

    figlet(message, (_error, data) => {
        console.log(gradient.pastel.multiline(data))
    })
}

await sleep()

await winner()