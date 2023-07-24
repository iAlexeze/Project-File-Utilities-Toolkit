#!/bin/bash

# File Content Filter:
# Write a script that takes a filename as input and filters out lines containing a specific keyword. 
# The script should create a new file with the filtered content and display the number of matching lines.

# Input file
filename="filter.txt"

# Keyword to search for
keyword="ipsum"

# Find lines containing the keyword and store them in a new file
grep -i "$keyword" "$filename" > "keyword.txt"

# Display the number of matching lines
num_matching_lines=$(grep -ic "$keyword" "$filename")

echo "Number of lines containing the keyword '$keyword': $num_matching_lines"


