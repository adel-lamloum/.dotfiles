#!/bin/bash

###################################################################################################################################
#                                                                                                                                 #
# Author: ADEL LAMLOUM                                                                                                            # 
# Title : Install Adel Default Arch Apps                                                                                          #
#                                                                                                                                 #
###################################################################################################################################
echo "##########################################"
echo "####### this is selected adel's apps #####"
sudo pacman -Syu
sudo pacman -S --noconfirm --needed remmina
sudo pacman -S --noconfirm --needed xcolor
sudo pacman -S --noconfirm --needed xorg-xkill
sudo pacman -S --noconfirm --needed bash-completion
sudo pacman -S --noconfirm --needed gimp
sudo pacman -S --noconfirm --needed vlc
sudo pacman -S --noconfirm --needed timeshift
sudo pacman -S --noconfirm --needed calibre
sudo pacman -S --noconfirm --needed emacs
sudo pacman -S --noconfirm --needed neovim
sudo pacman -S --noconfirm --needed kdenlive
sudo pacman -S --noconfirm --needed gnome-disk-utility
sudo pacman -S --noconfirm --needed gparted
sudo pacman -S --noconfirm --needed meld
sudo pacman -S --noconfirm --needed qbittorrent
sudo pacman -S --noconfirm --needed nitrogen
sudo pacman -S --noconfirm --needed galculator
sudo pacman -S --noconfirm --needed pamac
sudo pacman -S --noconfirm --needed bat
sudo pacman -S --noconfirm --needed git
sudo pacman -S --noconfirm --needed fd
sudo pacman -S --noconfirm --needed gitfiend
sudo pacman -S --noconfirm --needed hardcode-fixer-git
sudo pacman -S --noconfirm --needed hardinfo2
sudo pacman -S --noconfirm --needed ripgrep
sudo pacman -S --noconfirm --needed python-pywal
sudo pacman -S --noconfirm --needed man-db
sudo pacman -S --noconfirm --needed man-pages
sudo pacman -S --noconfirm --needed visual-studio-code-bin
sudo pacman -S --noconfirm --needed zsh
sudo pacman -S --noconfirm --needed zsh-completions
sudo pacman -S --noconfirm --needed zsh-syntax-highlighting
sudo pacman -S --noconfirm --needed wget
sudo pacman -S --noconfirm --needed neofetch
sudo pacman -S --noconfirm --needed cups
sudo pacman -S --noconfirm --needed geany
sudo pacman -S --noconfirm --needed okular
sudo pacman -S --noconfirm --needed oh-my-zsh-git
sudo pacman -S --noconfirm --needed flatpak
sudo pacman -S --noconfirm --needed ffmpeg
sudo pacman -S --noconfirm --needed inkscape
sudo pacman -S --noconfirm --needed dconf-editor
sudo pacman -S --noconfirm --needed brave
sudo pacman -S --noconfirm --needed flameshot
sudo pacman -S --noconfirm --needed simplescreenrecorder
sudo pacman -S --noconfirm --needed font-manager


echo "###################Done###################"
