#! /bin/bash

echo "[+] Install simple-hyprland"
git clone https://github.com/gaurav210233/simple-hyprland.git ~/simple-hyprland
cd ~/simple-hyprland/scripts/installer
sudo sh install.sh

echo "[+] Install sddm-astronaut-theme"
sudo pacman -S --needed qt6-5compat qt6-declarative qt6-svg sddm
sudo git clone https://github.com/keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme
sudo cp /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/
