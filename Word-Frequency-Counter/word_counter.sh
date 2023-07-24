#!/bin/bash

# Word Frequency Counter:
# Write a script that takes a filename as input and counts the frequency of each word in the file. 
# The script should display the top N most frequent words along with their frequencies.

# Input file
filename="words.txt"

# Remove punctuations and convert words to uppercase - one word per line
clear_file=$(cat "$filename" | tr -d '[:punct:]' | tr '[:lower:]' '[:upper:]' | tr -s '[:space:]' '\n')

# Sort the words with the frequency
word_freq=$(echo "$clear_file" | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2, $1}' | column -t)

echo "Word Frequency"
echo "$word_freq"
