#!/bin/bash

###################################################################################################################################
#                                                                                                                                 #
# Author: ADEL LAMLOUM                                                                                                            #
# Title : Install Adel Default Hyprland Apps                                                                                      #
#                                                                                                                                 #
###################################################################################################################################

# Update the system
sudo pacman -Syu --noconfirm

# Install Hyprland and related tools
sudo pacman -S --noconfirm --needed hyprland hyprpaper hyprpicker hyprlock hyprshot waybar xdg-desktop-portal-hyprland hyprcursor

# Install terminal and file management tools
sudo pacman -S --noconfirm --needed kitty dolphin yazi meld gedit

# Install system utilities
sudo pacman -S --noconfirm --needed network-manager-applet swaync scrot nwg-look font-manager gnome-disk-utility paru

# Install multimedia and graphics tools
sudo pacman -S --noconfirm --needed calibre gimp krita kdenlive imagemagick ffmpeg vlc obs-studio handbrake video-trimmer

# Install development tools
sudo pacman -S --noconfirm --needed git nodejs ripgrep fd
paru -S --noconfirm --needed visual-studio-code-bin

# Install productivity and office tools
sudo pacman -S --noconfirm --needed libreoffice-fresh pdfarranger rnote thunderbird telegram-desktop zoom

# Install miscellaneous tools
sudo pacman -S --noconfirm --needed neofetch lolcat yt-dlp wget zsh zathura zathura-pdf-mupdf zathura-ps zathura-djvu

echo "Installation complete!"
