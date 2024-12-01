#!/usr/bin/env bash

# Directory where your wallpapers are stored
WALLPAPER_DIR="home/adel/wallpapers"

# The interval in seconds (3 minutes)
INTERVAL=180

# Change the wallpaper indefinitely every 3 minutes
while true; do
  # Pick a random wallpaper from the directory
  WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)
  
  # Set the wallpaper using feh
  feh --bg-fill "$WALLPAPER"
  
  # Wait for 3 minutes before changing the wallpaper again
  sleep $INTERVAL
done

