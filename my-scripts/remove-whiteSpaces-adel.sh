#!/usr/bin/env bash

# Loop through all files in the current directory
for f in *; do
    # Check if the file name contains spaces
    if [[ "$f" == *" "* ]]; then
        # Replace spaces with underscores and rename the file
        mv "$f" "$(echo $f | tr ' ' '_')"
    fi
done
