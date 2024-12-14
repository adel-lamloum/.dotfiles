#!/bin/bash

function main() {
  # Unload and kill hyprpaper
  hyprctl hyprpaper unload all
  killall hyprpaper

  # Create or clear the hyprpaper configuration file
  echo "splash = false" >~/.config/hypr/hyprpaper.conf
  echo "ipc = true" >>~/.config/hypr/hyprpaper.conf

  # Get the list of monitors
  monitors=$(hyprctl monitors -j | jq -r ".[] | .name")

  # Loop through each monitor and set a random wallpaper
  for monitor in $monitors; do
    wallpaper=$(fd ".png|.jpg|.jpeg|.webp" ~/wallpapers/ | shuf -n1)
    if [ -z "$wallpaper" ]; then
      echo "No wallpaper found for monitor $monitor. Skipping."
      continue
    fi
    echo "preload = $wallpaper" >>~/.config/hypr/hyprpaper.conf
    echo "wallpaper = $monitor,$wallpaper" >>~/.config/hypr/hyprpaper.conf
  done

  # Start hyprpaper in the background
  hyprpaper &

  # Sleep for 180 seconds before restarting the process
  sleep 180
  main
}

# Ensure jq is installed
if ! command -v jq &> /dev/null; then
  echo "jq could not be found. Please install jq to continue."
  exit 1
fi

# Ensure fd is installed
if ! command -v fd &> /dev/null; then
  echo "fd could not be found. Please install fd to continue."
  exit 1
fi

# Run the main function
main
