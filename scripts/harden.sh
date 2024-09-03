#! /bin/bash
MOZILLA="$(find ~/.mozilla -name "*.default-release")"

echo "[+] Install tools"
yay -S --needed --noconfirm arch-audit haveged libpwquality lynis rkhunter shh
sudo systemctl enable --now haveged

echo "[+] Configure rkhunter"
sudo rkhunter --update
sudo rkhunter -c

echo "[+] Kernel Hardening"
cd ~ || exit
git clone https://github.com/MikeHorn-git/Kernel-Hardening.git
cd Kernel-Hardening/scripts || exit
chmod +x install.sh
sudo ./install.sh

echo "[+] Quad9 DNS"
echo "nameserver 9.9.9.9" | sudo tee /etc/resolv.conf
sudo chattr +i /etc/resolv.conf

echo "[+] Firefox Hardening"
cd ~ || exit
git clone https://github.com/arkenfox/user.js.git
cd user.js || exit
cp prefsCleaner.sh updater.sh user.js "$MOZILLA"
cd "$MOZILLA" || exit
./prefsCleaner.sh

echo "[+] Disable core dump"
sudo sed -i "/# End of file/c* hard core 0\n* soft core 0\n# End of file" /etc/security/limits.conf

echo "[+] Restrict compiler to root"
sudo chmod o-rx /usr/bin/as
sudo chmod o-rx /usr/bin/cc
sudo chmod o-rx /usr/bin/g++
sudo chmod o-rx /usr/bin/gcc

echo "[+] Harden login.degs"
sudo sed -i "/UMASK                022/cUMASK              027" /etc/login.defs
sudo sed -i "/PASS_MIN_DAYS        0/cPASS_MIN_DAYS        1" /etc/login.defs
sudo sed -i "/PASS_MAX_DAYS        99999/cPASS_MAX_DAYS    60" /etc/login.defs
sudo sed -i "/PASS_WARN_AGE        7/cPASS_MAX_DAYS        14" /etc/login.defs

echo "[+] Clean"
rm -rf ~/Kernel-Hardening ~/user.js
