#!/usr/bin/env bash
#https://github.com/vmatare/thinkfan/issues/45#issuecomment-658830584

echo "options thinkpad_acpi fan_control=1 experimental=1" | sudo tee /etc/modprobe.d/thinkfan.conf
sudo modprobe -rv thinkpad_acpi
sudo modprobe -v thinkpad_acpi
