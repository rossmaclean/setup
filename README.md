# Server Setup

## Architecture

### Local
```
---------------------------       ---------------------------
|         Proxmox         |       |       RaspberryPi       |
--------------------------|       |-------------------------|
|   vm-apps  |  vm-dokku  |       |       OctoprintOS       |
--------------------------|       |-------------------------|
|    Nginx   |   Dokku    |       |        Octoprint        |
|   AdGuard  |            |       ---------------------------
|   Jenkins  |            |       
|  Portainer |            |       
|   Netdata  |            |
|   Graylog  |            |
|   MongoDB  |            |
|   MariaDB  |            |
---------------------------
```

### Remote
```
---------------------------       ---------------------------
|        SSDNodes         |       |       DigitalOcean      |
|-------------------------|       |-------------------------|
|        Cloudron         | --    |         Domain          |
|-------------------------|   ->  |      Spaces (Backup)    |
|        Bitwarden        |       ---------------------------
|        Nextcloud        |
|          Sogo           |
|          Minio          |
|        Minecraft        |
|          Ghost          |
|        Blackjack        |
---------------------------
```