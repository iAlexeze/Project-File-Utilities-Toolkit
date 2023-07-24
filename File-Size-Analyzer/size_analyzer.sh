#!/bin/bash

# Function to calculate the total size of all files in the directory
get_total_size() {
  local total=0
  for file in "$1"/*; do
    if [ -f "$file" ]; then
      total=$((total + $(stat -c %s "$file")))
    fi
  done
  echo "$total"
}

# Function to find the largest file in the directory
get_largest_file() {
  local largest=""
  local max_size=0
  for file in "$1"/*; do
    if [ -f "$file" ]; then
      local size=$(stat -c %s "$file")
      if [ $size -gt $max_size ]; then
        largest="$file"
        max_size=$size
      fi
    fi
  done
  echo "$largest"
}

# Function to find the smallest file in the directory
get_smallest_file() {
  local smallest=""
  local min_size=$(stat -c %s "$1"/* | sort -n | head -n 1)
  for file in "$1"/*; do
    if [ -f "$file" ]; then
      local size=$(stat -c %s "$file")
      if [ $size -eq $min_size ]; then
        smallest="$file"
      fi
    fi
  done
  echo "$smallest"
}

# Function to calculate the average file size in the directory
get_average_size() {
  local total_size=$(get_total_size "$1")
  local num_files=$(ls -1 "$1" | wc -l)
  local average=$((total_size / num_files))
  echo "$average"
}

# Main script starts here

# Take the directory name as input
read -p "Enter the directory name: " dir

# Check if the directory exists
if [ ! -d "$dir" ]; then
  echo "Directory not found: $dir"
  exit 1
fi

# Display the list of files sorted by size
echo "List of files sorted by size (largest to smallest):"
ls -S "$dir"

# Calculate and display the total size
total_size=$(get_total_size "$dir")
echo "Total size of all files: $total_size bytes"

# Calculate and display the average file size
average_size=$(get_average_size "$dir")
echo "Average file size: $average_size bytes"

# Find and display the largest file
largest_file=$(get_largest_file "$dir")
echo "Largest file: $largest_file (Size: $(stat -c %s "$largest_file") bytes)"

# Find and display the smallest file
smallest_file=$(get_smallest_file "$dir")
echo "Smallest file: $smallest_file (Size: $(stat -c %s "$smallest_file") bytes)"
