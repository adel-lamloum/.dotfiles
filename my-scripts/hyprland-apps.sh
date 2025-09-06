


# System Apps

paru -S wofi waybar wlogout hyprpolkitagent --noconfirm

# Notofication
paru -S swaync --noconfirm

# Screenshot
paru -S grimblast --noconfirm

# File Manager
paru -S nautilus nautilus-image-converter nautilus-open-any-terminal imagemagick nautilus-image-converter folder-color-nautilus 
sudo pacman -S sushi 

# Clipboard
paru -S wl-clipboard wl-clip-persist clipse-bin --noconfirm

# Themes and Icons
paru -S nwg-look papirus-icon-theme --noconfirm

# Wallpaper and Lockscreen
paru -S hyprlock swaylock swww waypaper --noconfirm 

# Sound Devices

paru -S pipewire pipewire-pulse pipewire-alsa wireplumber pavucontrol --noconfirm

# Firewall
sudo pacman -S ufw
sudo ufw enable
sudo systemctl enable ufw.service

# Bluetooth
paru -S network-manager-applet bluez bluez-utils bluez-obex blueman --noconfirm
sudo systemctl enable bluetooth.service





