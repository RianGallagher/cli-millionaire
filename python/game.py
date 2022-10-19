import inquirer
from yaspin import yaspin
import os
import time

player_name = ""


def welcome():
    print("Who Wants To Be A Python Millionaire")
    print(
        """
    HOW TO PLAY 
    I am a process on your computer.
    If you get any question wrong I will be killed
    So get all the questions right...
    """
    )


welcome()


def ask_name():
    answers = inquirer.prompt(
        [
            inquirer.Text(
                "player_name", message="What is your name?", default="Player"
            ),
        ]
    )
    global player_name
    player_name = answers["player_name"]


ask_name()


def handle_answer(isCorrect: bool):
    spinner = yaspin(text="Checking answer...", color="yellow")
    spinner.start()
    time.sleep(2)
    spinner.stop()

    if isCorrect:
        spinner.ok(f"Nice work { player_name }.")
    else:
        spinner.fail(f"💀💀💀 Game over, you lose {player_name}!")
        exit(1)


def question_1():
    correct = "1991"
    answer = inquirer.prompt(
        [
            inquirer.List(
                "answer",
                message="Python was created by Guido van Rossum and released in what Year?",
                choices=["1989", "1995", "2000", correct],
            )
        ]
    )
    handle_answer(answer["answer"] == correct)


question_1()


def winner():
    os.system("clear")
    print(f"Congrats {player_name}! \n $ 1 , 0 0 0 , 0 0 0")


winner()
