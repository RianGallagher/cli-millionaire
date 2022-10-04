#!/usr/bin/zsh

player_name=

RED='\033[0;41m'
BLUE='\033[44m'
NC='\033[0m'

# RGB='\033[38;2;40;177;249m'

# START='\033[38;2;3;3;3m'
# END='\033[38;2;3;3;3m'

# declare -a step

# # steps is the number of colours passed.

# # only gets run once per gradient.
# stepize() {
#     start=$1
#     end=$2
#     steps=$3

#     length=${#start[@]}

#     for ((i = 0; i < ${length}; i++)); do
#         step[$i]=$(expr $(expr "${end[i]}" - "${start[i]}") / "$steps")
#     done

#     for i in "${step[@]}"; do
#         echo "$i"
#     done
# }

# gradient=("\033[38;2;${start[0]};${start[1]};${start[2]}m")
# start=(247 11 11)
# end=(11 11 247)
# # steps=10
# # stepize $start $end $steps

# interpolate() {
#     start=$1
#     end=$2
#     steps=$3
#     RGB_MAX=(256 256 256)

#     for ((i = 0; i < $steps; i++)); do
#         declare -a color

#         length=${#start[@]}

#         for ((j = 0; j < ${length}; j++)); do
#             # step[$i]=$(expr $(expr "${end[i]}" - "${start[i]}") / "$steps")
#             color[$j]=$(expr "${step[j]}" \* "$i" + "${start[j]}")
#             if [[ "${color[$j]}" -lt 0 ]]; then
#                 color[$j]=$(expr "${color[$j]}" + "${RGB_MAX[$j]}")
#             else
#                 color[$j]=$(expr "${color[$j]}" % "${RGB_MAX[$j]}")
#             fi
#         done
#         gradient[$i]="\033[38;2;${color[0]};${color[1]};${color[2]}m"
#     done

#     for i in "${gradient[@]}"; do
#         echo "$i"
#     done
# }

# create_gradient() {
#     steps=$1

#     stepize $start $end $steps
#     interpolate $start $end $steps
# }

# # create the gradient
# foo="Who Wants To Be A Bash Millionaire?"
# create_gradient ${#foo}

# to_print=""

# for ((i = 0; i < ${#foo}; i++)); do
#     to_print="${to_print}${gradient[i]}${foo:$i:1}"
# done

# printf "${to_print}"

animate() {
    text=$1

    # create_gradient ${#foo}

    for i in {1..7}; do

        # for ((i = 0; i < ${#text}; i++)); do
        #     printf "${gradient[i]}${text:$i:1}"
        # done

        # Moved the cursor 1 up. Move the cursor to column 0 (?) erase the entire line. Print the text with the colour
        # altered by $i
        # printf "\033[1F\033[G\033[2K\033[0;3%sm$text\n" $i
        printf "\033[1F\033[G\033[2K\033[38;2;40;1%s7;249m$text\n" $i
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
