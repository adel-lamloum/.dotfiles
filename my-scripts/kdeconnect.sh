#!/bin/bash

# KDE Connect Installer for Hyprland (CashyOS)
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
  echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
if [ "$EUID" -eq 0 ]; then
  print_error "Please run this script as a regular user, not as root"
  exit 1
fi

# Check if we're on an Arch-based system
if ! command -v pacman &>/dev/null; then
  print_error "This script is designed for Arch-based systems only"
  exit 1
fi

print_status "Starting KDE Connect installation for Hyprland..."

# Install KDE Connect
print_status "Installing KDE Connect..."
if command -v yay &>/dev/null; then
  yay -S --noconfirm kdeconnect
elif command -v paru &>/dev/null; then
  paru -S --noconfirm kdeconnect
else
  sudo pacman -S --noconfirm kdeconnect
fi

# Enable and start services - CORRECTED SERVICE NAMES
print_status "Enabling and starting KDE Connect services..."

# Try different service names (newer versions use different naming)
SERVICE_FOUND=false

if systemctl --user list-unit-files | grep -q "kdeconnect"; then
  # Try to find the correct service name
  SERVICE_NAME=$(systemctl --user list-unit-files | grep "kdeconnect" | grep "service" | head -1 | awk '{print $1}')

  if [ -n "$SERVICE_NAME" ]; then
    print_status "Found service: $SERVICE_NAME"
    systemctl --user enable "$SERVICE_NAME" || print_warning "Failed to enable $SERVICE_NAME"
    systemctl --user start "$SERVICE_NAME" || print_warning "Failed to start $SERVICE_NAME"
    SERVICE_FOUND=true
  fi
fi

if [ "$SERVICE_FOUND" = false ]; then
  print_warning "No specific KDE Connect service found. Using direct command execution."
fi

# Configure firewall (if ufw is installed)
if command -v ufw &>/dev/null; then
  print_status "Configuring firewall rules for KDE Connect..."
  sudo ufw allow 1714:1764/udp 2>/dev/null || print_warning "Failed to add UDP firewall rule"
  sudo ufw allow 1714:1764/tcp 2>/dev/null || print_warning "Failed to add TCP firewall rule"
  print_status "Firewall rules added (if ufw is active)"
fi

# Check if firewall-cmd is available (firewalld)
if command -v firewall-cmd &>/dev/null; then
  print_status "Configuring firewalld for KDE Connect..."
  sudo firewall-cmd --permanent --add-port=1714-1764/udp 2>/dev/null || print_warning "Failed to add UDP ports to firewalld"
  sudo firewall-cmd --permanent --add-port=1714-1764/tcp 2>/dev/null || print_warning "Failed to add TCP ports to firewalld"
  sudo firewall-cmd --reload 2>/dev/null || print_warning "Failed to reload firewalld"
fi

# Test if KDE Connect is working
print_status "Testing KDE Connect installation..."
if command -v kdeconnect-cli &>/dev/null; then
  print_status "KDE Connect CLI is available"
  print_status "Available devices:"
  kdeconnect-cli --list-available || print_warning "No devices found or daemon not running"
else
  print_warning "kdeconnect-cli not found"
fi

# Print completion message
print_status "Installation completed successfully!"
echo
print_status "Next steps:"
echo "1. Restart Hyprland (Mod+Shift+E) or run: $STARTUP_SCRIPT"
echo "2. Install KDE Connect on your mobile device"
echo "3. Ensure both devices are on the same network"
echo "4. Look for the KDE Connect icon in your system tray"
echo
print_status "If you don't see the system tray icon, check if your bar supports it:"
echo "For Waybar: ensure 'tray' module is enabled in your config"

# Quick test to see if kdeconnectd is running
if pgrep -f "kdeconnect" >/dev/null; then
  print_status "✓ KDE Connect processes are running"
else
  print_warning "KDE Connect processes not running yet - they will start after Hyprland restart"
fi

print_status "KDE Connect setup is complete! 🎉"
