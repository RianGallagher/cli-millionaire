#!/usr/bin/bash

player_name=

RED='\033[0;41m'
BLUE='\033[44m'
NC='\033[0m'

animate() {
    text=$1
    for i in {1..7}; do
        # Moved the cursor 1 up. Move the cursor to column 0 (?) erase the entire line. Print the text with the colour
        #  altered by $i
        printf "\033[1F\033[G\033[2K\033[0;3%sm$text\n" $i
        sleep 0.3
    done
}

welcome() {
    clear

    animate "Who Wants To Be A Bash Millionaire?"

    echo -e "${BLUE}HOW TO PLAY${NC}
I am a process on your computer.
If you get any question wrong I will be ${RED}killed${NC}
So get all the questions right..."
}

welcome

ask_name() {
    default_name="Player"
    read -p "What is your name? ($default_name) " player_name

    player_name=${player_name:-$default_name}
}

ask_name

handle_answer() {
    correct=$1
    answer=$2

    echo "Checking answer..."
    sleep 2

    if [ $correct == $answer ]; then
        echo "Nice work $player_name."
        sleep 1
    else
        echo "💀💀💀 Game over, you lose $player_name!"
        exit
    fi
}

question_1() {
    correct="1989"
    PS3='Bash is a Unix shell and command language released in: '
    answers=("1992" $correct "1973" "1984")
    select answer in "${answers[@]}"; do
        case $answer in
        "1992" | $correct | "1973" | "1984")
            handle_answer $correct $answer
            break
            ;;
        *) echo "invalid option $REPLY" ;;
        esac
    done
}

question_1

winner() {
    clear

    message="Congrats, $player_name!
    \$1,000,000"

    echo $message
}

winner
