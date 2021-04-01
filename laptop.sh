#!/bin/bash
set -e

echo "Running setup for laptop"

echo "Updating system"
sudo pacman -Syyu

echo "Installing Yay"
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

echo "Installing packages using Pacman"
sudo pacman -S discord chromium nodejs jdk11-openjdk jdk8-openjdk npm virt-manager qemu vde2 ebtables dnsmasq bridge-utils openbsd-netcat


echo "Installing packages using Yay"
yay -S balena-etcher
yay -S jetbrains-toolbox
yay -S zoom
yay -S icaclient
yay -S spotify

echo "Enabling libvirtd service"
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

echo "All done"
