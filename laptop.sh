#!/bin/bash
set -e

echo "Running setup for laptop"

echo "Change Pacman to total download"
sudo sed -i -e 's/#TotalDownload/TotalDownload/g' /etc/pacman.conf

echo "Updating system"
sudo pacman -Syyu

echo "Installing Yay"
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

echo "Installing packages using Pacman"
sudo pacman -S discord chromium nodejs jdk11-openjdk jdk8-openjdk npm virt-manager qemu vde2 ebtables dnsmasq bridge-utils openbsd-netcat docker docker-compose lutris
sudo usermod -aG docker ross

echo "Enabling dhcpcd service"
sudo systemctl enable dhcpcd.service --now

echo "Installing packages using Yay"
yay -S jetbrains-toolbox
yay -S zoom
yay -S icaclient
yay -S spotify

echo "Enabling libvirtd service"
sudo systemctl enable libvirtd.service --now

echo "All done"
