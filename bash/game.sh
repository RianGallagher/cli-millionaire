#!/usr/bin/bash

player_name=

RED='\033[0;41m'
BLUE='\033[44m'
NC='\033[0m'

RGB_MAX=(256 256 256)

declare -a step

# Figure out the distance between the start and end colour for each part of the RGB colour.
stepize() {
    start=$1
    end=$2
    steps=$3

    length=${#start[@]}

    for ((i = 0; i < ${length}; i++)); do
        step[$i]=$(expr $(expr $(expr "${end[i]}" - "${start[i]}") / "$steps"))
    done
}

# Create the colours for each step in the gradient.
interpolate() {
    start=$1
    end=$2
    steps=$3

    for ((i = 0; i < $steps; i++)); do
        declare -a color

        length=${#start[@]}

        for ((j = 0; j < ${length}; j++)); do
            color[$j]=$(expr "${step[j]}" \* "$i" + "${start[j]}")
            if [[ "${color[$j]}" -lt 0 ]]; then
                color[$j]=$(expr "${color[$j]}" + "${RGB_MAX[$j]}")
            else
                color[$j]=$(expr "${color[$j]}" % "${RGB_MAX[$j]}")
            fi
        done
        gradient[$i]="\033[38;2;${color[0]};${color[1]};${color[2]}m"
    done
}

create_gradient() {
    start=$1
    end=$2
    steps=$3

    stepize $start $end $steps
    interpolate $start $end $steps
}

animate() {
    text=$1

    for i in {0..7}; do
        #  If it's the first index, create the colours.
        if [ $i == 0 ]; then
            start=(63 94 251)
            end=(252 70 107)
        # Otherwise, increment the start and end colour.
        else
            start=($(expr $(expr 63 + $(expr "${step[0]}" \* $i)) % 256) $(expr $(expr 94 + $(expr "${step[1]}" \* $i)) % 256) $(expr $(expr 251 + $(expr "${step[2]}" \* $i)) % 256))
            end=($(expr $(expr 252 + $(expr "${step[0]}" \* $i)) % 256) $(expr $(expr 70 + $(expr "${step[1]}" \* $i)) % 256) $(expr $(expr 107 + $(expr "${step[2]}" \* $i)) % 256))
        fi

        gradient=("\033[38;2;${start[0]};${start[1]};${start[2]}m")

        create_gradient $start $end ${#text}
        gradient_string=""
        for ((i = 0; i < ${#text}; i++)); do
            gradient_string="${gradient_string}${gradient[i]}${text:$i:1}"
        done

        # Moved the cursor 1 up. Move the cursor to column 0 (?) erase the entire line. Print the text with the colour
        # altered by $i
        printf "\033[1F\033[G\033[2K$gradient_string\n"
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
