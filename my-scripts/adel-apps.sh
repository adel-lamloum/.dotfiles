#!/bin/bash

###################################################################################################################################
#                                                                                                                                 #
# Author: ADEL LAMLOUM                                                                                                            #
# Title : Install Adel Default Arch Apps                                                                                          #
#                                                                                                                                 #
###################################################################################################################################

echo "##########################################"
echo "####### INSTALL SELECTED ADEL'S APPS #####"
sleep 3
sudo pacman -Syu
#sudo pacman -S --noconfirm --needed arcolinux-meta-fun
sudo pacman -S --noconfirm --needed audacity
#sudo pacman -S --noconfirm --needed brave
sudo pacman -S --noconfirm --needed blanket
#sudo pacman -S --noconfirm --needed bitwarden
sudo pacman -S --noconfirm --needed bat
sudo pacman -S --noconfirm --needed bash-completion
#sudo pacman -S --noconfirm --needed calibre
#sudo pacman -S --noconfirm --needed discord
sudo pacman -S --noconfirm --needed ddgr # search from terminal duck duck go engine 
sudo pacman -S --noconfirm --needed dconf-editor
#sudo pacman -S --noconfirm --needed emacs
sudo pacman -S --noconfirm --needed fd
sudo pacman -S --noconfirm --needed filezilla
sudo pacman -S --noconfirm --needed fzf
#sudo pacman -S --noconfirm --needed font-manager
sudo pacman -S --noconfirm --needed figlet
sudo pacman -S --noconfirm --needed ffmpeg
sudo pacman -S --noconfirm --needed fribidi # arabic support
sudo pacman -S --noconfirm --needed flameshot
#sudo pacman -S --noconfirm --needed fish 
sudo pacman -S --noconfirm --needed flatpak
sudo pacman -S --noconfirm --needed gitfiend
sudo pacman -S --noconfirm --needed galculator
sudo pacman -S --noconfirm --needed gparted
sudo pacman -S --noconfirm --needed gimp
sudo pacman -S --noconfirm --needed git
#sudo pacman -S --noconfirm --needed geany
sudo pacman -S --noconfirm --needed gnome-disk-utilit
sudo pacman -S --noconfirm --needed hardcode-fixer-git
sudo pacman -S --noconfirm --needed handbrake
sudo pacman -S --noconfirm --needed harfbuzz # arabic support
sudo pacman -S --noconfirm --needed hardinfo2
sudo pacman -S --noconfirm --needed imagemagick
sudo pacman -S --noconfirm --needed inkscape
sudo pacman -S --noconfirm --needed krita
sudo pacman -S --noconfirm --needed kdenlive
#sudo pacman -S --noconfirm --needed korganizer
sudo pacman -S --noconfirm --needed kitty
sudo pacman -S --noconfirm --needed lolcat
sudo pacman -S --noconfirm --needed libreoffice-fresh
sudo pacman -S --noconfirm --needed meld
sudo pacman -S --noconfirm --needed man-db
sudo pacman -S --noconfirm --needed man-pages
sudo pacman -S --noconfirm --needed neovim
#sudo pacman -S --noconfirm --needed nomacs
sudo pacman -S --noconfirm --needed neofetch
sudo pacman -S --noconfirm --needed nodejs
#sudo pacman -S --noconfirm --needed nitrogen # wallpaper app
#sudo pacman -S --noconfirm --needed oh-my-zsh-git
sudo pacman -S --noconfirm --needed obs-studio
#sudo pacman -S --noconfirm --needed okular
sudo pacman -S --noconfirm --needed python-pywal
sudo pacman -S --noconfirm --needed paru-git
sudo pacman -S --noconfirm --needed pycharm-community-edition
#sudo pacman -S --noconfirm --needed pamac
sudo pacman -S --noconfirm --needed pdfarranger
sudo pacman -S --noconfirm --needed qutebrowser
sudo pacman -S --noconfirm --needed qbittorrent
sudo pacman -S --noconfirm --needed ripgrep # search tool
sudo pacman -S --noconfirm --needed rnote
#sudo pacman -S --noconfirm --needed remmina
sudo pacman -S --noconfirm --needed syncthing
#sudo pacman -S --noconfirm --needed screenkey
#sudo pacman -S --noconfirm --needed strawberry
sudo pacman -S --noconfirm --needed simplescreenrecorder
sudo pacman -S --noconfirm --needed spotify
#sudo pacman -S --noconfirm --needed timeshift
sudo pacman -S --noconfirm --needed thunderbird
sudo pacman -S --noconfirm --needed thefuck
sudo pacman -S --noconfirm --needed toilet
sudo pacman -S --noconfirm --needed tauon-music-box
#sudo pacman -S --noconfirm --needed tumbler #to creat thumbnail for thunar
sudo pacman -S --noconfirm --needed telegram-desktop
sudo pacman -S --noconfirm --needed visual-studio-code-bin
sudo pacman -S --noconfirm --needed vlc
sudo pacman -S --noconfirm --needed variety
sudo pacman -S --noconfirm --needed video-trimmer
sudo pacman -S --noconfirm --needed wget
sudo pacman -S --noconfirm --needed xournalpp
sudo pacman -S --noconfirm --needed xcolor
sudo pacman -S --noconfirm --needed xorg-xkill
sudo pacman -S --noconfirm --needed yt-dlp 
sudo pacman -S --noconfirm --needed zoom
sudo pacman -S --noconfirm --needed zsh
sudo pacman -S --noconfirm --needed zathura
sudo pacman -S --noconfirm --needed zathura-pdf-mupdf
sudo pacman -S --noconfirm --needed zathura-ps
sudo pacman -S --noconfirm --needed zathura-djvu
sudo pacman -S --noconfirm --needed zsh-completions
sudo pacman -S --noconfirm --needed zsh-syntax-highlighting

# Zip and archive
sudo pacman -S --noconfirm --needed gzip
sudo pacman -S --noconfirm --needed p7zip
sudo pacman -S --noconfirm --needed unace
sudo pacman -S --noconfirm --needed unrar
sudo pacman -S --noconfirm --needed unzip
sudo pacman -S --noconfirm --needed thunar-archive-plugin

# INSTALLING virt-manager
#sudo pacman -S --noconfirm --needed virt-manager
#sudo systemctl start libvirtd.service
#sudo systemctl enable libvirtd.service

# install and enable tlp
sudo pacman -S --noconfirm --needed tlp
sudo systemctl enable tlp.service

# Install cups printing
sudo pacman -S --noconfirm --needed cups
sudo pacman -S --noconfirm --needed cups-pdf
sudo pacman -S --noconfirm --needed ghostscript
sudo pacman -S --noconfirm --needed gsfonts
sudo pacman -S --noconfirm --needed gutenprint
sudo pacman -S --noconfirm --needed gtk3-print-backends
sudo pacman -S --noconfirm --needed libcups
sudo pacman -S --noconfirm --needed system-config-printer
sudo pacman -S --noconfirm --needed sane
sudo pacman -S --noconfirm --needed simple-scan


## mount mobile storages
#sudo pacman -S --noconfirm --needed android-file-transfer
sudo pacman -S --noconfirm --needed gvfs-mtp

# network tools for wm
# # this app run over the bar you can select any wifi or edit it
#sudo pacman -S --noconfirm --needed networkmanager-dmenu-git 

# zsh plugins
sudo pacman -S --noconfirm --needed zsh-syntax-highlighting
echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc


echo "##################ARCH BASED APPS INSTALLED##################"

sleep 10
echo "##################INSTALL APPS FOR GAMING#####################"
sudo pacman -S --needed wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls \
  mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error \
  lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo \
  sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama \
  ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 \
  lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader
sudo pacman -S --noconfirm --needed lutris
##AUR PACKAGES TO INSTALL
#googler "app to search in terminal"

echo "###################INSTALLING PACKAGES DONE###################"
sleep 2
echo "####################NOW REBOOT#################################"
sleep 5
reboot

########################### SCRIPT END ###############################################
