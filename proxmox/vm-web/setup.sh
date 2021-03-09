#!/bin/bash
set -e

check_port_53() {
  if sudo lsof -i :53
    then
      echo "Port 53 in use, fixing that..."
      sudo sed -i 's/#DNS=/DNS=192.168.1.1/' '/etc/systemd/resolved.conf'
      sudo sed -i 's/#DNSStubListener=yes/DNSStubListener=no/' '/etc/systemd/resolved.conf'
      sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
      echo "Port 53 should now be free, rebooting..."
      sudo reboot
  fi
}

setup_nginx_config() {
  wget https://github.com/rossmaclean/setup/raw/main/proxmox/vm-web/nginx-config.tar.gz
  tar -xvzf nginx-config.tar.gz -C docker/container-data/

  cd docker/container-data/nginx/sites-enabled
  ln -s ../sites-available/*.conf .
  cd ~
}

update_and_install_tools() {
  sudo apt update
  sudo apt dist-upgrade -y

  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh

  sudo apt install docker-compose fail2ban -y
  sudo usermod -aG docker ross
}

setup() {
  update_and_install_tools

  mkdir docker
  mkdir docker/container-data

  setup_nginx_config

  curl https://raw.githubusercontent.com/rossmaclean/setup/main/proxmox/vm-web/docker-compose.yml > docker/docker-compose.yml
  curl https://raw.githubusercontent.com/rossmaclean/setup/main/proxmox/vm-web/template.env > docker/.env

  sudo ufw allow ssh
  yes | sudo ufw enable

  check_port_53
}

echo "Beginning setup"
setup
echo "Setup complete, after populating .env file docker-compose can be run"