#!/bin/bash

# Check if a directory is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: ./file_analyzer.sh <directory>"
  exit 1
fi

# Check if the provided directory exists
if [ ! -d "$1" ]; then
  echo "Directory does not exist."
  exit 1
fi

# Analyze files in the directory
directory="$1"
file_count=$(ls -l "$directory" | grep "^-" | wc -l)
largest_file=$(ls -lS "$directory" | grep "^-" | head -n 1 | awk '{ print $NF }')
total_size=$(du -sh "$directory" | awk '{ print $1 }')

# Output the analysis
echo "File Analysis for Directory: $directory"
echo "-----------------------------"
echo "Total Files: $file_count"
echo "Largest File: $largest_file"
echo "Total Size: $total_size"
