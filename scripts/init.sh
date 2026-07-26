#!/usr/bin/env bash
# shellcheck disable=SC2317

set -euo pipefail

# shellcheck source=/dev/null
if [[ -f /etc/os-release ]]; then
	. /etc/os-release
else
	echo "[-] OS undetected"
	exit 1
fi

if [[ $ID != "arch" ]]; then
	echo "[-] ArchLinux undetected"
	exit 1
else
	echo "[+] ArchLinux detected"
fi

echo "[+] Installing BlackArch repository"
curl -O https://blackarch.org/strap.sh
echo "00688950aaf5e5804d2abebb8d3d3ea1d28525ed strap.sh" | sha1sum -c
chmod +x strap.sh
sudo ./strap.sh
rm -f strap.sh
sudo pacman -Syyu --noconfirm

echo "[+] Installing utilities"
sudo pacman -S --needed --noconfirm \
	base-devel \
	fastfetch \
	htop \
	keepassxc \
	firefox \
	neovim \
	yay \
	zsh

yay -S --needed --noconfirm oh-my-zsh-git

echo "[+] Configuring virt-manager"
sudo pacman -S --needed --noconfirm \
	dmidecode \
	dnsmasq \
	qemu-base \
	virt-manager

sudo systemctl enable --now libvirtd.service

sudo sed -i \
	-e 's/^#unix_sock_group = "libvirt"/unix_sock_group = "libvirt"/' \
	-e 's/^#unix_sock_ro_perms = "0777"/unix_sock_ro_perms = "0777"/' \
	/etc/libvirt/libvirtd.conf

sudo usermod -aG libvirt "$USER"
sudo systemctl restart libvirtd.service
sudo virsh net-autostart default
