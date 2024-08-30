#! /bin/bash

echo "[+] Generate secure ssh key"
ssh-keygen -t ed25519 -a 100

echo "[+] Configure Github"
git config --global user.email "MikeHornProton@proton.me"
git config --global user.name "MikeHorn-git"

echo "[+] Install dotfiles"
git clone https://github.com/MikeHorn-git/dotfiles.git
cd dotfiles
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

echo "[+] Install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "[+] Add alias"
echo "alias vim=nvim" >> ~/.zshrc
source ~/.zshrc

