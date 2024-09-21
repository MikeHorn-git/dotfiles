#! /bin/bash

echo "[+] Generate secure ssh key"
ssh-keygen -t ed25519 -a 100

echo "[+] Install dotfiles"
git clone https://github.com/MikeHorn-git/dotfiles.git
cd dotfiles || exit
cp -r nvim tmux ~/.config
sudo cp hyprland/arch/hyprland.conf ~/.config/hypr
sudo cp etc/thinkfan.conf /etc/
sudo cp etc/systemd/system/thinkfan.service.d/override.conf /etc/systemd/system/thinkfan.service.d/
sudo cp etc/sddm.conf /etc/
cd ../; rm -rf dotfiles

echo "[+] Install blackarch repos"
curl -O https://blackarch.org/strap.sh
echo 26849980b35a42e6e192c6d9ed8c46f0d6d06047 strap.sh | sha1sum -c
chmod +x strap.sh
sudo ./strap.sh
rm ./strap.sh
sudo pacman -Syyu --noconfirm

echo "[+] Configure virt-manager"
sudo pacman -S --needed --noconfirm dmidecode dnsmasq qemu-base virt-manager
sudo systemctl enable --now libvirtd.service
sudo sed -i "/#unix_sock_group = \"libvirt\"/cunix_sock_group = \"libvirt\"" /etc/libvirt/libvirtd.conf
sudo sed -i "/#unix_sock_ro_perms = \"0777\"/cunix_sock_ro_perms = \"0777\"" /etc/libvirt/libvirtd.conf
sudo usermod -a -G libvirt "$(whoami)"
sudo systemctl restart libvirtd.service

echo "[+] Configure thinkfan"
yay -S thinkfan
sudo systemctl enable --now thinkfan.service

echo "[+] Install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "[+] Add alias"
echo "alias vim=nvim" >> ~/.zshrc
# shellcheck source=/dev/null
source ~/.zshrc

echo "[+] Set Timezone"
sudo timedatectl set-timezone Europe/Paris

echo "[+] Clean Packages"
yay -Rs "$(yay -Qqdt)"

echo "[+] Create Folders"
mkdir ~/Documents ~/Downloads ~/Projects
