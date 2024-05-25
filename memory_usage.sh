#!/bin/bash

# Get current memory usage for all running programs
# Author: Alexell

declare -A mem_usage

# Iterate over all running processes
for pid in /proc/[0-9]*
do
  if [ -r "$pid/status" ]; then
    progname=$(awk '/Name:/ {print substr($0, index($0,$2))}' "$pid/status")
    mem=$(awk '/VmRSS:/ {print $2}' "$pid/status")

    if (( mem > 0 )); then
      if [ -n "${mem_usage[$progname]}" ]; then
        mem_usage[$progname]=$((mem_usage[$progname] + mem))
      else
        mem_usage[$progname]=$mem
      fi
    fi
  fi
done

# Print the header
printf "%-20s\t%s\n" "PROGRAM" "MEMORY USED"

# Prepare data for sorting and filtering
output=""
for progname in "${!mem_usage[@]}"
do
  mem_kb=${mem_usage[$progname]}
  mem_mb=$((mem_kb / 1024))
  mem_frac=$(( (mem_kb % 1024) * 100 / 1024 ))

  if (( mem_mb >= 1 )); then
    output+="$mem_mb.$mem_frac $progname\n"
  fi
done

# Sort and print the results
echo -e "$output" | sort -k1,1nr | while IFS= read -r line
do
  mem_mb=$(echo "$line" | awk '{print $1}')
  progname=$(echo "$line" | awk '{for (i=2; i<=NF; i++) printf "%s%s", $i, (i<NF ? " " : "")}')
  
  if [ -n "$progname" ] && [[ "$mem_mb" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
    printf "%-20s\t%s MB\n" "$progname" "$mem_mb"
  fi
done

# Calculate the overall memory usage
overall_memory=$(echo -e "$output" | awk '{sum += $1} END {printf "%.2f", sum}')

printf "\nTotal memory used: %s MB (only by listed processes)\n" "$overall_memory"
