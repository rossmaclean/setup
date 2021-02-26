#!/bin/bash
set -e

setup() {
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo apt install docker-compose -y

  mkdir docker
  cd docker
  mkdir container-data

  curl https://raw.githubusercontent.com/rossmaclean/setup/main/lan-server-ubuntu/docker-compose.yml > docker-compose.yml
  curl https://raw.githubusercontent.com/rossmaclean/setup/main/lan-server-ubuntu/template.env > .env
}

compose() {
  cd docker
  docker-compose up -d

  docker stop $(docker ps -a -q)
  sudo chown -R 1000 container-data
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