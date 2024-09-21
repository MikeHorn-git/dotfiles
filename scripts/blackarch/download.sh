#! /bin/bash

echo "[+] Download OVA"
wget https://ftp.halifax.rwth-aachen.de/blackarch/ova/blackarch-linux-2023.04.01.ova
clear
echo "[+] Extract OVA"
tar -xvf blackarch-linux-2023.04.01.ova
clear
echo "[+] Convert OVA to QCOW2"
qemu-img convert -f vmdk blackarch-disk001.vmdk -O qcow2 blackarch.qcow2
clear
echo "[+] Clean Up"
rm blackarch.ovf blackarch.mf blackarch-linux-2023.04.01.ova blackarch-disk001.vmdk
