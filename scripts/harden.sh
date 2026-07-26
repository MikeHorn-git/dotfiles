#!/usr/bin/env bash

set -euo pipefail

echo "[+] SSH key"
sudo pacman -S openssh --needed --noconfirm
ssh-keygen -t ed25519 -a 100

echo "[+] Quad9 DNS"
echo "nameserver 9.9.9.9" | sudo tee /etc/resolv.conf
sudo chattr +i /etc/resolv.conf

echo "[+] Disable core dump"
sudo sed -i "/# End of file/c* hard core 0\n* soft core 0\n# End of file" /etc/security/limits.conf

echo "[+] Harden login.defs"
sudo sed -i "/UMASK                022/cUMASK              027" /etc/login.defs
sudo sed -i "/PASS_MIN_DAYS        0/cPASS_MIN_DAYS        1" /etc/login.defs
sudo sed -i "/PASS_MAX_DAYS        99999/cPASS_MAX_DAYS    60" /etc/login.defs
sudo sed -i "/PASS_WARN_AGE        7/cPASS_MAX_DAYS        14" /etc/login.defs

echo "[+] Install utilities"
yay -S --needed --noconfirm haveged libpwquality lynis macchanger
sudo systemctl enable --now haveged.service

echo "[+] Install firewall"
sudo pacman -S --needed --noconfirm nftables
if [ ! -f /etc/nftables.conf ]; then
	sudo cp etc/nftables.conf /etc/nftables.conf
	sudo nft -f /etc/nftables.conf
fi

echo "[+] Harden kernel"
git clone https://github.com/MikeHorn-git/kernel.git

echo "[+] Harden firefox"
yay -S --needed --noconfirm arkenfox-user.js
