# VM-Web
This VM holds all the applications use for application development.

## Setup
The `setup.sh` script will take care of updating the system, installing docker, and cloning the docker-compose file.

Once the script has been run on the server, simply fill in the missing values in the .env file and run docker-compose.

## Apps
### Nginx
To create a sym link use `sudo ln -s ../sites-available/portainer.conf .` Make sure this is run inside the sites-enabled directory.

When any changes are made make sure to run
`docker exec -it nginx nginx -s reload`
to reload nginx inside the container. *RESTARTING THE CONTAINER WILL NOT WORK*.

### AdGuard
You can comment out the http port once setup is complete, and the subdomain is pointing to it.
Don't change the port during installation.

## Ports
The ports of many containers are commented out. This is because we are using nginx in a 
container. It lets us use the ports without exposing (as in ports section not literal expose) them.

### Databases
Databases are excluded from this as connecting to them via port 80 is just wrong.

## Backups
The backup container backs up the data to S3 storage. They have still to update their docs on how to restore data on the event of a failure.

## Helpful Commands
Stop all containers
`docker stop $(docker ps -q)`

Remove all containers
`docker rm $(docker ps -a -q)`

Remove all volumes
`docker volume rm $(docker volume ls -q)`

Nginx sym link
`sudo ln -s ../sites-available/portainer.conf .`

Nginx reload
`docker exec -it nginx nginx -s reload`

Change directory ownership
`sudo chown -R 1000 container-data`

Generate SHA2 for Graylog
`echo -n "Enter Password: " && head -1 </dev/stdin | tr -d '\n' | sha256sum | cut -d" " -f1`