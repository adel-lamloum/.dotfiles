# Enable bluetooth
sudo systemctl enable --now cups.service
sudo pacman -S --noconfirm --needed bluez
sudo pacman -S --noconfirm --needed bluez-libs
sudo pacman -S --noconfirm --needed bluez-utils
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

