#!/bin/bash

# File Backup:
# Write a script that takes a filename as input and creates a backup of the file by appending the current date to the filename. 
# For example, if the input file is "data.txt," the backup file should be named "data_2023-07-01.txt" (assuming the date is July 1, 2023).

clear
# Original file
original_file="data.txt"

# Check if file exists
if [[ ! -f "$original_file" ]]; then
    echo "Error: File '$original_file' not found."
    exit 1
else
    echo "Backing up '$original_file'"
        while [ "$SECONDS" -lt 2 ]; do
            echo -n "."
            sleep 0.5
            echo -n "."
            sleep 0.5
            echo -n "."
            sleep 0.5
        done
fi

# Get the current date in the format "YYYY-MM-DD"
current_date=$(date +%Y-%m-%d)

# Create backup directory if it doesn't exist
backup_dir="backup"
mkdir -p "$backup_dir"

# Copy file to the backup location (e.g., backup/ directory) with the new filename
backup_file="${original_file%.*}_${current_date}.${original_file##*.}"

# Copy original file into backup directory
cp -p "$original_file" "$backup_dir/$backup_file"

# Check if the backup was successful
if [[ $? -eq 0 ]]; then
    printf "\nBackup created: '%s'\n" "$backup_dir/$backup_file"
else
    echo "Error: Backup failed."
fi
