#!/bin/bash

###################################################################################################################################
#                                                                                                                                 #
# Author: ADEL LAMLOUM                                                                                                            #
# Title : Install Adel Default Arch Apps                                                                                          #
#                                                                                                                                 #
###################################################################################################################################
echo "##################### NOW WE UNINSTALL UNWANTED APPS ######################"
sudo pacman -Rs --noconfirm --needed firefox
sudo pacman -Rs --noconfirm --needed discord
echo "##################### UNINSTALLING DONE##################################"
echo "##########################################"
echo "####### INSTALL SELECTED ADEL'S APPS #####################################"
sleep 3
sudo pacman -Syu
sudo pacman -S --noconfirm --needed remmina
sudo pacman -S --noconfirm --needed variety
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
sudo pacman -S --noconfirm --needed krita
sudo pacman -S --noconfirm --needed thunderbird
sudo pacman -S --noconfirm --needed fd
sudo pacman -S --noconfirm --needed libreoffice-fresh
sudo pacman -S --noconfirm --needed virt-manager
sudo systemctl start libvirtd.service
sudo systemctl enable libvirtd.service
sudo pacman -S --noconfirm --needed arcolinux-meta-fun
sudo pacman -S --noconfirm --needed audacity
sudo pacman -S --noconfirm --needed lollypop
sudo pacman -S --noconfirm --needed rnote
sudo pacman -S --noconfirm --needed rnote
sudo pacman -S --noconfirm --needed bitwarden
sudo pacman -S --noconfirm --needed imagemagick
sudo pacman -S --noconfirm --needed pdfarranger
sudo pacman -S --noconfirm --needed nomacs
sudo pacman -S --noconfirm --needed tlp
sudo systemctl enable tlp.service
sudo pacman -S --noconfirm --needed syncthing
echo "###################INSTALLING PACKAGES DONE###################"
sleep 2
echo "###################LETS INSTALL FLATPAK PACKAGES#####################"

sleep 3

flatpak install -y flathub io.github.benini.scid
flatpak install -y flathub com.github.d4nj1.tlpui
flatpak install -y flathub com.jetbrains.PyCharm-Community
flatpak install -y Flatseal
flatpak install -y org.telegram.desktop
flatpak install -y drawio
flatpak install -y midori
flatpak install -y com.obsproject.Studio
flatpak install -y com.github.xournalpp.xournalpp
flatpak install -y bottles
flatpak install -y com.github.arminstraub.krop
flatpak install -y org.onlyoffice.desktopeditors
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub com.github.taiko2k.tauonmb
flatpak install -y flathub it.mijorus.gearlever
flatpak install -y flathub us.zoom.Zoom
flatpak install -y flathub net.ankiweb.Anki
flatpak install -y flathub org.gnome.gitlab.YaLTeR.VideoTrimmer
flatpak install -y flathub dev.geopjr.Calligraphy
flatpak install -y flathub dev.bragefuglseth.Keypunch
flatpak install -y flathub org.gaphor.Gaphor
flatpak install -y flathub io.github.flattool.Warehouse
flatpak install -y flathub fr.handbrake.ghb
flatpak install -y flathub org.filezillaproject.Filezilla
echo "#####################DONE###############################################"
sleep 3

echo "##########NOW REBOOT#######"
reboot

########################### SCRIPT END ###############################################
