#!/bin/bash
set -e

setup() {
  mkdir docker
  cd docker
  mkdir container-data

  curl https://raw.githubusercontent.com/rossmaclean/setup/main/lan-server-ubuntu/docker-compose.yml > docker-compose.yml
  curl https://raw.githubusercontent.com/rossmaclean/setup/main/lan-server-ubuntu/template.env > .env
}

compose() {
  docker-compose -f docker/docker-compose.yml up -d

  docker stop $(docker ps -a -q)
  sudo chown -R 1000 container-data
  docker-compose -f docker/docker-compose.yml up -d
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