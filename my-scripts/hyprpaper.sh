#!/bin/bash

function main() {
  hyprctl hyprpaper unload all
  killall hyprpaper

  echo "splash = false" >~/.config/hypr/hyprpaper.conf
  echo "ipc = true" >>~/.config/hypr/hyprpaper.conf
  # monitors=$(hyprctl monitors -j | jq -r ".[] | .name")

  # for monitor in $monitors; do
  #   wallpaper=$(fd ".png|.jpg|.jpeg|.webp" ~/Pictures/wallpapers/ | shuf -n1)
  #   echo "preload = $wallpaper" >>~/.config/hypr/hyprpaper.conf
  #   echo "wallpaper = $monitor,$wallpaper" >>~/.config/hypr/hyprpaper.conf
  # done

  wallpaper=$(fd ".png|.jpg|.jpeg|.webp" ~/wallpapers/ | shuf -n1)
  echo "preload = $wallpaper" >>~/.config/hypr/hyprpaper.conf
  echo "wallpaper = ,$wallpaper" >>~/.config/hypr/hyprpaper.conf

  echo "# BACKGROUND
background {eDP-1
    monitor =
    blur_passes = 2
    contrast = 1
    brightness = 0.5
    vibrancy = 0.2
    vibrancy_darkness = 0.2
    path = $wallpaper   # supports png, jpg, webp (no animations, though)
  }
"
  hyprpaper &
  sleep 180
  main
}

main
