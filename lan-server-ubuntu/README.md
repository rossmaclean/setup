# Server Setup
## General Notes
* Might have to allow port 53 for AdGuard https://www.linuxuprising.com/2020/07/ubuntu-how-to-free-up-port-53-used-by.html
* Will have to give correct permissions for Jenkins data directory https://github.com/jenkinsci/docker/issues/177 (You must set the correct permissions in the host before you mount volumes sudo chown 1000 volume_dir). 
  This might also apply to other container but not confirmed.

I've found that running `sudo chown -R 1000 container-data` fixes issues with this for all. 
However, this often has to be ran after creation running before doesn't work.

## Docker
Install Docker using the convenience script.
```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

## Apps
### AdGuard
You can comment out the http port once setup is complete and the domain is pointing to it.
Don't change the port during installation.

### Jenkins
Need to get working.

## Ports
The ports of many containers are commented out. This is because we are using nginx in a 
container. It lets us use the ports without exposing (as in ports section not literal expose) them.

### Databases
Databases are excluded from this as connecting to them via port 80 is just wrong.

## Helpful Commands
Stop all containers
`docker stop $(docker ps -q)`

Remove all containers
`docker rm $(docker ps -a -q)`

Nginx sym link
`sudo ln -s ../sites-available/portainer.conf .`

Nginx reload
`docker exec -it nginx nginx -s reload`

Change directory ownership
`sudo chown -R 1000 container-data`