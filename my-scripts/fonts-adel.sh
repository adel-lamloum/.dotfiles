
#!/bin/bash

###################################################################################################################################
#                                                                                                                                 #
# Author: ADEL LAMLOUM                                                                                                            #
# Title : Install Adel Default Fonts                                                                                              #
#                                                                                                                                 #
###################################################################################################################################

# Update the system
sudo pacman -Syu --noconfirm

# List of fonts to install
FONTS=(
    ttf-bitstream-vera
    ttf-dejavu
    ttf-droid
    ttf-hack
    ttf-inconsolata
    ttf-liberation
    ttf-roboto
    ttf-roboto-mono
    ttf-ubuntu-font-family
    ttf-cascadia-code-nerd
    ttf-font-awesome
    awesome-terminal-fonts
    ttf-jetbrains-mono-nerd
    ttf-jetbrains-mono
    otf-hermit
    ttf-firacode-nerd
)

# Install all fonts in one command
sudo pacman -S --noconfirm --needed "${FONTS[@]}"

echo "Font installation complete!"


