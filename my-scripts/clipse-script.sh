#!/bin/bash

history_file="/home/adel/.config/clipse/clipboard_history.json"

while true; do
  # Check if the file has changed
  if [[ "$last_modified" != "$(stat -c %Y "$history_file")" ]]; then
    last_modified="$(stat -c %Y "$history_file")"

    # Extract the last 5 entries
    latest_entries=$(tail -n 5 "$history_file")

    # Format the entries for display
    formatted_entries=$(echo "$latest_entries" | sed 's/\n/\n- /g')

    # Send a command to Kitty to display the entries in a specific window
    kitty --title "Clipse Clipboard History" -e "echo '$formatted_entries'"
  fi

  sleep 5  # Adjust the polling interval as needed
done
