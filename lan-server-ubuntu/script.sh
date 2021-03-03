#!/bin/bash
set -e

checkPort53() {
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

generate_nginx_config() {
  # Download files
  wget https://github.com/rossmaclean/setup/raw/main/lan-server-ubuntu/nginx-config.tar.gz
  tar -xvzf nginx-config.tar.gz -C docker/container-data/

  cd docker/container-data/nginx/sites-enabled
  ln -s ../sites-available/*.conf .
  cd ~
  #ln -s docker/container-data/nginx/sites-available/*.conf docker/container-data/nginx/sites-enabled/
}

setup() {
  sudo apt update
  sudo apt dist-upgrade -y

  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo apt install docker-compose fail2ban -y
  sudo usermod -aG docker ross

  mkdir docker
  mkdir docker/container-data
  generate_nginx_config

  curl https://raw.githubusercontent.com/rossmaclean/setup/main/lan-server-ubuntu/docker-compose.yml > docker/docker-compose.yml
  curl https://raw.githubusercontent.com/rossmaclean/setup/main/lan-server-ubuntu/template.env > docker/.env

  sudo ufw allow ssh
  yes | sudo ufw enable

  checkPort53
}

compose() {
  cd docker
  docker-compose up -d

  docker stop $(docker ps -a -q)
  docker-compose up -d
}

if [ $1 -eq 0 ]
  then
    echo "Doing setup"
    setup
elif [ $1 -eq 1 ]
  then
    echo "Doing compose"
    compose
else
    echo "Arg not valid. Please enter 0 to setup and 1 to compose."
fi