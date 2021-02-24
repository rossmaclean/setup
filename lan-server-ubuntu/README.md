# Server Setup
## General Notes
* Might have to allow port 53 for AdGuard https://www.linuxuprising.com/2020/07/ubuntu-how-to-free-up-port-53-used-by.html
* Will have to give correct permissions for Jenkins data directory https://github.com/jenkinsci/docker/issues/177 (You must set the correct permissions in the host before you mount volumes sudo chown 1000 volume_dir). 
  This might also apply to other container but not confirmed.

## Nginx
Good luck lol.
Make sure the directories and nginx.conf file already exist
The dir structure is:

```
.
+-- nginx.conf
+-- conf.d
|   +-- sites-available
|   +-- sites-enabled
```
 
To create a sym link use `sudo ln -s ../sites-available/portainer.conf .` Make sure this is run inside the sites-enabled directory.

When any changes are made make sure to run
`docker exec -it nginx nginx -s reload`
to reload nginx inside the container. *RESTARTING THE CONTAINER WILL NOT WORK*.