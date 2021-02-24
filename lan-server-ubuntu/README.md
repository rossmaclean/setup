# Server Setup
* had to allow port 53 for addguard https://www.linuxuprising.com/2020/07/ubuntu-how-to-free-up-port-53-used-by.html
* had to give correct perms for jenkins https://github.com/jenkinsci/docker/issues/177 (You must set the correct permissions in the host before you mount volumes sudo chown 1000 volume_dir)
* (Why do I only have to do the above for Jenkins? Should I do it for all?)