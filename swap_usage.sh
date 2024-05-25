#!/bin/bash

# Get current swap usage for all running programs
# Author: Alexell

declare -A swap_usage

for DIR in /proc/[0-9]*
do
    if [ -r "$DIR/smaps" ]; then
        PROGNAME=$(<"$DIR/comm")

        SWAP=$(awk '/Swap/ { sum += $2 } END { print sum }' "$DIR/smaps")

        if (( SWAP > 0 )); then
            if [ -n "${swap_usage[$PROGNAME]}" ]; then
                swap_usage[$PROGNAME]=$((swap_usage[$PROGNAME] + SWAP))
            else
                swap_usage[$PROGNAME]=$SWAP
            fi
        fi
    fi
done

OVERALL=0

# Prepare data for sorting
output=""
for PROGNAME in "${!swap_usage[@]}"
do
    output+="$PROGNAME ${swap_usage[$PROGNAME]}\n"
    OVERALL=$((OVERALL + swap_usage[$PROGNAME]))
done

# Sort and print the results
printf "%-20s\t%s\n" "Program" "Swapped"
echo -e "$output" | sort -k2,2nr | while IFS=' ' read -r PROGNAME SWAPPED
do
    if [[ "$SWAPPED" =~ ^[0-9]+$ ]]; then
        printf "%-20s\t%d KB\n" "$PROGNAME" "$SWAPPED"
    fi
done

printf "\nTotal swap used: %s KB\n" "$OVERALL"
