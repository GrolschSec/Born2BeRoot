# [TUTO] Born To Be Root

## Basic Instalation

## Port Forwarding in VirtualBox

## Add an SSH Server:
- Log as root: 
	```su```
- Install the SSH Server: 
	```apt install openssh-server```
- Enable the SSH Server at startup: 
	```systemctl enable ssh```

## Configure the SSH Server:
- In linux the configuration files are in /etc/ and specially for ssh is '/etc/ssh/'.
- The file for the server config is sshd_config.
- Edit the file:
	```sudo nano /etc/ssh/sshd_config```
- We'll edit two parameters in the file the root login perm and the port we want ssh use.
- Change the port config to '4242' and uncomment:
	![sshd_config PORT](https://github.com/GrolschSec/BornToBeRoot/blob/main/Screenshot/15.png)
