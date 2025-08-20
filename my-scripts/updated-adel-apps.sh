#!/bin/bash

###################################################################################################################################
#                                                                                                                                 #
# Author: ADEL LAMLOUM                                                                                                            #
# Title : Install Adel Default Arch Apps                                                                                          #
#                                                                                                                                 #
###################################################################################################################################
# run this to simulate the installation ./adel-apps.sh --dry-run
# Function to display usage information
usage() {
  echo "Usage: $0 [--dry-run] [--help]"
  echo "  --dry-run: Simulate the installation without actually installing anything."
  echo "  --help: Display this help message."
  exit 1
}

# Function to log messages
log() {
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# Function to install packages
install_packages() {
  local packages=("$@")
  for pkg in "${packages[@]}"; do
    if ! pacman -Qi "$pkg" &>/dev/null; then
      log "Installing $pkg..."
      if [[ $DRY_RUN -eq 0 ]]; then
        sudo pacman -S --noconfirm --needed "$pkg" || log "Failed to install $pkg"
      else
        log "Dry run: Would install $pkg"
      fi
    else
      log "$pkg is already installed."
    fi
  done
}

# Function to enable and start a service
enable_service() {
  local service=$1
  log "Enabling and starting $service..."
  if [[ $DRY_RUN -eq 0 ]]; then
    sudo systemctl enable "$service" || log "Failed to enable $service"
    sudo systemctl start "$service" || log "Failed to start $service"
  else
    log "Dry run: Would enable and start $service"
  fi
}

# Parse command-line arguments
DRY_RUN=0
while [[ $# -gt 0 ]]; do
  case "$1" in
  --dry-run)
    DRY_RUN=1
    shift
    ;;
  --help)
    usage
    ;;
  *)
    echo "Unknown option: $1"
    usage
    ;;
  esac
done

log "##########################################"
log "####### INSTALL SELECTED ADEL'S APPS #####"
sleep 3

# Update system
log "Updating system..."
if [[ $DRY_RUN -eq 0 ]]; then
  sudo pacman -Syu --noconfirm || log "Failed to update system"
else
  log "Dry run: Would update system"
fi

# ==================================================
# 1. Audio & Video Editing
# ==================================================
log "Installing Audio & Video Editing tools..."
audio_video_packages=(
  audacity ffmpeg handbrake kdenlive obs-studio simplescreenrecorder vlc video-trimmer
)
install_packages "${audio_video_packages[@]}"

# ==================================================
# 2. Graphics & Design
# ==================================================
log "Installing Graphics & Design tools..."
graphics_design_packages=(
  gimp inkscape krita nomacs figlet imagemagick
)
install_packages "${graphics_design_packages[@]}"

# ==================================================
# 3. Productivity & Office
# ==================================================
log "Installing Productivity & Office tools..."
productivity_packages=(
  calibre libreoffice-fresh pdfarranger zathura zathura-pdf-mupdf zathura-ps zathura-djvu xournalpp
)
install_packages "${productivity_packages[@]}"

# ==================================================
# 4. Development Tools
# ==================================================
log "Installing Development Tools..."
development_packages=(
  neovim git lazygit nodejs ripgrep fd fzf emacs
)
install_packages "${development_packages[@]}"

# ==================================================
# 5. System Utilities
# ==================================================
log "Installing System Utilities..."
system_utilities_packages=(
  bash-completion bat ddgr dconf-editor fish flameshot font-manager galculator gparted gnome-disk-utility hardinfo2 man-db man-pages neofetch pamac paru-git thunar-archive-plugin tlp xorg-xkill zsh zsh-completions zsh-syntax-highlighting
)
install_packages "${system_utilities_packages[@]}"

# Enable and start tlp service
enable_service tlp

# ==================================================
# 6. Networking & Remote Access
# ==================================================
log "Installing Networking & Remote Access tools..."
networking_packages=(
  syncthing wget yt-dlp
)
install_packages "${networking_packages[@]}"

# ==================================================
# 7. Gaming
# ==================================================
#log "Installing Gaming tools..."
#gaming_packages=(
#  wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils #lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-#libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt #lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader lutris
#)
#install_packages "${gaming_packages[@]}"

# ==================================================
# 8. Printing & Scanning
# ==================================================
log "Installing Printing & Scanning tools..."
printing_packages=(
  cups cups-pdf ghostscript gsfonts gutenprint gtk3-print-backends libcups system-config-printer sane simple-scan
)
install_packages "${printing_packages[@]}"

# ==================================================
# 9. Miscellaneous
# ==================================================
log "Installing Miscellaneous tools..."
miscellaneous_packages=(
  blanket lolcat meld rnote telegram-desktop thefuck toilet variety xcolor zoom
)
install_packages "${miscellaneous_packages[@]}"

# ==================================================
# 10. Archive & Compression
# ==================================================
log "Installing Archive & Compression tools..."
archive_packages=(
  gzip p7zip unace unrar unzip
)
install_packages "${archive_packages[@]}"

# ==================================================
# 11. Mobile Device Support
# ==================================================
log "Installing Mobile Device Support tools..."
mobile_packages=(
  gvfs-mtp
)
install_packages "${mobile_packages[@]}"

# ==================================================
# 12. Arabic Language Support
# ==================================================
log "Installing Arabic Language Support tools..."
arabic_packages=(
  fribidi harfbuzz
)
install_packages "${arabic_packages[@]}"

# ==================================================
# Final Steps
# ==================================================
log "###################INSTALLING PACKAGES DONE###################"
sleep 2
log "####################NOW REBOOT#################################"
sleep 5

if [[ $DRY_RUN -eq 0 ]]; then
  reboot
else
  log "Dry run: Would reboot now"
fi

########################### SCRIPT END ###############################################
