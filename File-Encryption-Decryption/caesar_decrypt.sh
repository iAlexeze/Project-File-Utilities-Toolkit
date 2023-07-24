#!/bin/bash

# Read the filename from command-line argument
filename="$1"

# Check if the file exists
if [ ! -f "$filename" ]; then
    echo "Error: File not found: $filename"
    exit 1
fi

# Ask the user for the decryption key
echo -n "Enter decryption key (a number between 1 and 25): "
read key

# Validate the decryption key
if ! [[ "$key" =~ ^[1-9]$|^1[0-9]$|^2[0-5]$ ]]; then
    echo "Error: Invalid decryption key. Please enter a number between 1 and 25."
    exit 1
fi

# Create a new filename for the decrypted file
decrypted_filename="${filename%.*}_decrypted.txt"

# Perform the decryption and write the decrypted content to the new file
awk -v key="$key" '
    function decrypt_char(c) {
        # Shift upper-case letters
        if (c ~ /[A-Z]/) {
            return sprintf("%c", (c - "A" + 26 - key) % 26 + "A")
        }
        # Shift lower-case letters
        else if (c ~ /[a-z]/) {
            return sprintf("%c", (c - "a" + 26 - key) % 26 + "a")
        }
        # Leave other characters unchanged
        else {
            return c
        }
    }

    {
        for (i = 1; i <= length($0); i++) {
            printf("%s", decrypt_char(substr($0, i, 1)))
        }
        printf("\n")
    }
' "$filename" > "$decrypted_filename"

echo "Decryption successful. Decrypted file: $decrypted_filename"
