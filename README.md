# Born2BeRoot

## Table of contents

## VirtualBox Instalation
First you have to download the OS you want to use for your Virtual Machine.  
In this tutorial i'll use Debian 11.3.0 ([bullseye](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso)).  
In VirtualBox click on New:  
![VirtualBox New VM](https://github.com/GrolschSec/Born2BeRoot/blob/main/Screenshot/1.png)  
Name you VM, give the path where you want to save your VM (In 42 School, you have to put you VM in 'sgoinfre' if not it will crash).  
Then select type 'Linux' and version 'Debian (64 bit).  
![VM Info](https://github.com/GrolschSec/Born2BeRoot/blob/main/Screenshot/2.png)  

## Debian Instalation

## Port Forwarding in VirtualBox

## Add an SSH Server
Log as root:  
	```su```  
Install the SSH Server:  
	```apt install openssh-server```  
Enable the SSH Server at startup:   
	```systemctl enable ssh```  

## Configure the SSH Server
In linux the configuration files are in /etc/ and specially for ssh is '/etc/ssh/'.  
The file for the server config is sshd_config.  
Edit the file:  
	```nano /etc/ssh/sshd_config```  
We'll edit two parameters in the file the root login perm and the port we want ssh use.  
Change the port config to '4242' and uncomment:  
	![sshd_config PORT](https://github.com/GrolschSec/BornToBeRoot/blob/main/Screenshot/15.png)  
We don't want that someone can login directly to root trough ssh so we will prohibit it.  
Change the 'PermitRootLogin' to no:  
	![sshd_config PermitRootLogin](https://github.com/GrolschSec/BornToBeRoot/blob/main/Screenshot/16.png)
Restart now the SSH Server:  
	```systemctl restart ssh```  
## Install Sudo
Install the sudo package:  
	```apt install sudo```  
Add a user to the sudo group:  
	```/usr/sbin/usermod -aG sudo <username>```  
## Connect trough SSH:
Open a new terminal in your host machine.  
The basic syntax to connect with ssh is 'ssh username@IP'.  
Since we are not using the default ssh port (22) we'll have to add the flag '-p'.  
The port you will use to connect is the one you configured in VirtualBox Port Forwarding.  
The Ip we'll use is our loopback (127.0.0.1).  
Connecting:  
	```ssh -p 9042 <username>@127.0.0.1```  

## Install the Uncomplicated Firewall
Install the ufw package:  
	```sudo apt install ufw```  
Add a rule to allow any connexion to our ssh server:  
	```sudo ufw allow 4242```  
Enable the firewall:  
	```sudo ufw enable```  
You can check the firewall status:  
	```sudo ufw status```  
