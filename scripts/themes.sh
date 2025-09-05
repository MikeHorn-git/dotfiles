#!/usr/bin/env bash
#https://github.com/gaurav23b/simple-hyprland/blob/main/docs/theming.md

echo "[+] Install themes engines"
sudo pacman -S --needed --noconfirm kvantum nwg-look qt5ct qt6ct

echo "[+] Install GTK theme"
curl -L https://github.com/gaurav23b/simple-hyprland/raw/main/assets/themes/Catppuccin-Mocha.tar.xz | tar -xJ -C /usr/share/themes/

echo "[+] Install Icon theme"
curl -L https://github.com/gaurav23b/simple-hyprland/raw/main/assets/icons/Tela-circle-dracula.tar.xz | tar -xJ -C /usr/share/icons/

echo "[+] Install Kvantum theme"
yay -S --needed --noconfirm kvantum-theme-catppuccin-git
