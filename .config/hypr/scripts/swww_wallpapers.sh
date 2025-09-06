#!/usr/bin/env bash

# Define wallpaper directory and list images
DIR="/mnt/adel-data/wallpapers"

# Ensure swww daemon is running
swww query || swww-daemon

# Continuously change the wallpaper every 30 seconds
while true; do
    # Get the list of wallpaper images
    PICS=($(find "$DIR" -type f -name "*.jpg" -o -name "*.png" -o -name "*.jpeg"))

    # Select a random image from the list
    RANDOMPICS="${PICS[$RANDOM % ${#PICS[@]}]}"

    # Kill any running swaybg process (if running)
    if pidof waypaper > /dev/null; then
        pkill waypaper
    fi

    # Change wallpaper with transition
    swww img "$RANDOMPICS" --transition-fps 30 --transition-type any --transition-duration 3

    # Sleep for 600 seconds before changing again
    sleep 600s
done

