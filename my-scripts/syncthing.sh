#!/bin/bash

# Syncthing Auto-Setup Script for CashyOS/Hyprland
# This script installs Syncthing and configures it to auto-start with Hyprland

set -e # Exit on any error

echo "========================================"
echo "Syncthing Setup for CashyOS/Hyprland"
echo "========================================"

# Function to print status messages
print_status() {
    echo -e "\n[+] $1"
}

# Function to handle errors
error_exit() {
    echo -e "\n[!] ERROR: $1" >&2
    exit 1
}

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    error_exit "Please run this script as a regular user, not as root."
fi

# Check if we're on an Arch-based system
if ! command -v pacman &> /dev/null; then
    error_exit "This script is designed for Arch-based systems only."
fi

print_status "1. Installing Syncthing..."
sudo pacman -S --noconfirm syncthing || error_exit "Failed to install Syncthing"

print_status "2. Enabling Syncthing user service..."
systemctl --user enable syncthing.service || error_exit "Failed to enable user service"

print_status "3. Starting Syncthing service..."
systemctl --user start syncthing.service || error_exit "Failed to start service"

print_status "4. Checking service status..."
if systemctl --user is-active --quiet syncthing.service; then
    echo "✓ Syncthing service is running successfully"
else
    error_exit "Syncthing service is not running"
fi

print_status "7. Firewall configuration (optional)..."
# Check if ufw is installed and active
if command -v ufw &> /dev/null && sudo ufw status | grep -q "Status: active"; then
    read -p "Do you want to open Syncthing ports in firewall? (22000/tcp, 21025/udp) [y/N]: " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo ufw allow 22000/tcp
        sudo ufw allow 21025/udp
        sudo ufw reload
        echo "✓ Firewall ports opened for Syncthing"
    fi
fi

echo -e "\n========================================"
echo "Setup Complete! 🎉"
echo "========================================"
echo -e "\nNext steps:"
echo "1. Open http://localhost:8384 in your browser"
echo "2. Configure your sync folders and devices"
echo "3. Reboot or reload Hyprland to test auto-start"
echo -e "\nTo reload Hyprland config:"
echo "  Ctrl+Alt+E (default shortcut) or"
echo "  killall -SIGUSR2 Hyprland"

echo -e "\nLogs can be viewed with: journalctl --user -u syncthing.service -f"
