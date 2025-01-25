#!/bin/bash

# Define the source directories and files as arrays
CONFIG_DIRS=(
    "$HOME/.config/hypr"
    "$HOME/.config/wofi"
    "$HOME/.config/zathura"
    "$HOME/.config/mpv"
    "$HOME/.config/kitty"
)

CONFIG_FILES=(
    "$HOME/.config/starship.toml"
)

CONFIG_HOME_DIRS=(
    "$HOME/.emacs.d"
    "$HOME/.vim"
)

CONFIG_HOME_FILES=(
    "$HOME/.vimrc"
)

# Define the destination directory in your .dotfiles repo
DOTFILES_DIR="$HOME/.dotfiles"
DOTFILES_CONFIG_DIR="$DOTFILES_DIR/.config"


# Loop through each configuration directory in .config
for CONFIG_DIR in "${CONFIG_DIRS[@]}"; do
    # Get the base name of the config directory (e.g., "hypr", "wofi", "zathura")
    CONFIG_NAME=$(basename "$CONFIG_DIR")

    # Create the destination directory if it doesn't exist
    mkdir -p "$DOTFILES_CONFIG_DIR/$CONFIG_NAME"

    # Copy the configuration files
    cp -r "$CONFIG_DIR"/* "$DOTFILES_CONFIG_DIR/$CONFIG_NAME/"
done

# Loop through each configuration file in .config
for CONFIG_FILE in "${CONFIG_FILES[@]}"; do
    # Get the base name of the config file (e.g., "starship.toml")
    CONFIG_NAME=$(basename "$CONFIG_FILE")

    # Copy the configuration file
    cp "$CONFIG_FILE" "$DOTFILES_CONFIG_DIR/$CONFIG_NAME"
done

# Loop through each home directory configuration
for CONFIG_DIR in "${CONFIG_HOME_DIRS[@]}"; do
    # Get the base name of the config directory (e.g., ".emacs.d", ".vim")
    CONFIG_NAME=$(basename "$CONFIG_DIR")

    # Create the destination directory if it doesn't exist
    mkdir -p "$DOTFILES_DIR/$CONFIG_NAME"

    # Copy the configuration files
    cp -r "$CONFIG_DIR"/* "$DOTFILES_DIR/$CONFIG_NAME/"
done

# Loop through each home file configuration
for CONFIG_FILE in "${CONFIG_HOME_FILES[@]}"; do
    # Get the base name of the config file (e.g., ".vimrc")
    CONFIG_NAME=$(basename "$CONFIG_FILE")

    # Copy the configuration file
    cp "$CONFIG_FILE" "$DOTFILES_DIR/$CONFIG_NAME"
done

# Navigate to the .dotfiles directory
#cd "$DOTFILES_DIR"

# Add the changes to git
#git add .

# Commit the changes
#git commit -m "Update configuration files: hypr, wofi, zathura, mpv, kitty, starship.toml, .emacs.d, .vim, .vimrc"

# Push the changes to GitHub
#git push origin main

echo "Configuration files copied and pushed to .dotfiles repository."
