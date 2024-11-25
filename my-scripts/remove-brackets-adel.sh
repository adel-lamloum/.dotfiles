#!/bin/bash

# Loop through all files in the current directory
for file in *; do
    # Check if the file name contains brackets
    if [[ "$file" =~ \[.*\] ]]; then
        # Remove the brackets and their contents
        new_file=$(echo "$file" | sed 's/\[[^][]*\]//g')
        # Rename the file
        mv "$file" "$new_file"
    fi
done
