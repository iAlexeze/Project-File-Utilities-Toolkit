#!/bin/bash

# Read the filename from command-line argument
filename="$1"

# Check if the file exists
if [ ! -f "$filename" ]; then
    echo "Error: File not found: $filename"
    exit 1
fi

# Ask the user for the encryption key
echo -n "Enter encryption key (a number between 1 and 25): "
read key

# Validate the encryption key
if ! [[ "$key" =~ ^[1-9]$|^1[0-9]$|^2[0-5]$ ]]; then
    echo "Error: Invalid encryption key. Please enter a number between 1 and 25."
    exit 1
fi

# Create a new filename for the encrypted file
encrypted_filename="${filename%.*}_encrypted.txt"

# Perform the encryption and write the encrypted content to the new file
awk -v key="$key" '
    function encrypt_char(c) {
        # Shift upper-case letters
        if (c ~ /[A-Z]/) {
            return sprintf("%c", (c - "A" + key) % 26 + "A")
        }
        # Shift lower-case letters
        else if (c ~ /[a-z]/) {
            return sprintf("%c", (c - "a" + key) % 26 + "a")
        }
        # Leave other characters unchanged
        else {
            return c
        }
    }

    {
        for (i = 1; i <= length($0); i++) {
            printf("%s", encrypt_char(substr($0, i, 1)))
        }
        printf("\n")
    }
' "$filename" > "$encrypted_filename"

echo "Encryption successful. Encrypted file: $encrypted_filename"
