# Born2BeRoot

## Table of contents
- [VirtualBox Installation](https://github.com/GrolschSec/Born2BeRoot/blob/main/README.md#virtualbox-instalation)
- [Debian Installation](https://github.com/GrolschSec/Born2BeRoot/blob/main/README.md#debian-instalation)
- [Add an SSH Server](https://github.com/GrolschSec/Born2BeRoot/blob/main/README.md#add-an-ssh-server)
- [Configure the SSH Server](https://github.com/GrolschSec/Born2BeRoot/blob/main/README.md#configure-the-ssh-server)
- [Install Sudo](https://github.com/GrolschSec/Born2BeRoot/blob/main/README.md#install-sudo)
- [Configure Sudo](https://github.com/GrolschSec/Born2BeRoot/blob/main/README.md#configure-sudo)
- [Connect trough SSH](https://github.com/GrolschSec/Born2BeRoot/blob/main/README.md#connect-trough-ssh)
- [Install the Uncomplicated Firewall](https://github.com/GrolschSec/Born2BeRoot/blob/main/README.md#install-the-uncomplicated-firewall)
- [Set up a Strong Password Policy](https://github.com/GrolschSec/Born2BeRoot/blob/main/README.md#set-up-a-strong-password-policy)

## VirtualBox Installation
First you have to download the OS you want to use for your Virtual Machine.  
In this tutorial i'll use Debian 11.3.0 ([bullseye](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso)).  
In VirtualBox click on New:  
![VirtualBox New VM](https://github.com/GrolschSec/Born2BeRoot/blob/main/Screenshot/1.png)  
Name you VM, give the path where you want to save your VM (In 42 School, you have to put you VM in 'sgoinfre' if not it will crash).  
Then select type 'Linux' and version 'Debian (64 bit).  
![VM Info](https://github.com/GrolschSec/Born2BeRoot/blob/main/Screenshot/2.png)  
It will ask you how much memory you want to allocate to the VM (You can keep default value).  
For the hard disk, choose create a new one, VDI and Dynamicaly allocated and keep 8G default.  
Go to settings and then the storage, click under controller IDE, click the small disk as shown below:
![OS Select](https://github.com/GrolschSec/Born2BeRoot/blob/main/Screenshot/4.png)
Click choose a disk file and select your Debian ISO file.
### VirtualBox Port Forwarding
Since we are using a Virtual Machine and not a real one if we want to host services and access it from another machine we cannot just open a port in the Virtual Machine and leave it away, we'll have to use Port Forwarding.  
This just mean that we are gonna redirect the port of our VM to a local port of the host machine, in our example we'll redirect the port 4242 for our SSH Server to our local port 9042.  
We could use the local port 4242 too but in the 42 School this port is already used by another ssh service from the school, so we have to choose another one that isn't used (you can check the local tcp ports in use with the command: ```netstat -antp```).  
Go to the VM Settings and go to the submenu Network, select Advanced and click on port forwarding:
![Port Forwarding](https://github.com/GrolschSec/Born2BeRoot/blob/main/Screenshot/6.png)
Add the host port of your choice and the guest port 4242 (for ssh).
## Debian Instalation
- Language: English
- Location: France
- Keyboard: American English
- Network config will automatically process
- Hostname: YourLogin42 + 42
- Domain: Leave it blank
- Root Password: Set an password that you'll remember
- User Full Name: You can leave it blank
- Username: Any
- Password: A password you will remember

### Partition Disks
In this part i'll partition as it is asked for the bonus part, if you don't want to do the bonus you can skip this part and just choose 'Guided Partitioning with encrypted LVM'.  
1 - Choose Manual.  
2 - Choose SCSI1.  
3 - Create new empty partition table: yes.  
4 - Create the partition for boot:
![4](https://github.com/GrolschSec/Born2BeRoot/blob/main/Screenshot/boot/1.png)
![4](https://github.com/GrolschSec/Born2BeRoot/blob/main/Screenshot/boot/2.png)
![4](https://github.com/GrolschSec/Born2BeRoot/blob/main/Screenshot/boot/3.png)
![4](https://github.com/GrolschSec/Born2BeRoot/blob/main/Screenshot/boot/4.png)
![4](https://github.com/GrolschSec/Born2BeRoot/blob/main/Screenshot/boot/5.png)
![4](https://github.com/GrolschSec/Born2BeRoot/blob/main/Screenshot/boot/6.png)
![4](https://github.com/GrolschSec/Born2BeRoot/blob/main/Screenshot/boot/7.png)
![4](https://github.com/GrolschSec/Born2BeRoot/blob/main/Screenshot/boot/8.png)
5 - Now we have to make the encrypted partition and configure lvm to make the same as in the bonus part:
![5](https://github.com/GrolschSec/Born2BeRoot/blob/main/Screenshot/bonus.png)
6 - Select "Configure encrypted volumes".  
7 - Write the changes to disk and configure: Yes.  
8 - Create encrypted volume.  
9 - Select the free space(click space to select) and continue.  
10 - Write the change and erase the partition data.  
11 - Encryption Passphrase: Select a good password it'll serve you to decrypt your partition before entering the system.  
12 - Select "Configure the Logical Volume Manager".  
13 - Select "Create Volume Group".  
14 - Volume Group Name: LVMGroup.  
15 - Select the encrypted partition we just created (sd5_crypt).  
16 - Create Logical Volume.  
17 - Select LVMGroup.  
18 - Logical Volume Name: root  
19 - Logical Volume Size: 2G  
20 - Repeat line 16 to 19 for giving name as (swap, home, var, srv, tmp, var-log) and giving 1G as size.  
21 - Once you have all your lvm volume, finish.  
22 - Select the size below each Logical Volume.  
23 - For most of them you'll have to select "Use as Ext4".
24 - Then you'll have to select their mount point depending on which logical volume you target (Example: home Mount-Point = /home).  
25 - There is two execeptions:  
- First from the swap you'll select "Use as: swap area".  
- Second, from var-log, you select "Use as: ext4" and then for mount point you enter it manually "/var/log".  
  
26 - Finish Partitionning.  
### Finish Installation
- Installing the base system automatically.  
- Scan extra installation media: No  
- Configure the package manager: Select your country and the default link  
- Proxy: Leave it blank.  
- Participate in the package usage survey: No  
- Software Selection: Unselect Everything (Using space).  
- Install the Grub boot loader to your primary drive: Yes  
- Select the /dev/sda   
- Finish Instalation.  
## Add an SSH Server
Log as root:  
```  
su
```  
Install the SSH Server:  
```
apt install openssh-server
```  
Enable the SSH Server at startup:   
```  
systemctl enable ssh
```  

## Configure the SSH Server
In linux the configuration files are in /etc/ and specially for ssh is '/etc/ssh/'.  
The file for the server config is sshd_config.  
Edit the file:  
```  
nano /etc/ssh/sshd_config
```   
We'll edit two parameters in the file the root login perm and the port we want ssh use.  
Change the port config to '4242' and uncomment:  
	![sshd_config PORT](https://github.com/GrolschSec/BornToBeRoot/blob/main/Screenshot/15.png)  
We don't want that someone can login directly to root trough ssh so we will prohibit it.  
Change the 'PermitRootLogin' to no:  
	![sshd_config PermitRootLogin](https://github.com/GrolschSec/BornToBeRoot/blob/main/Screenshot/16.png)
Restart now the SSH Server:  
```  
systemctl restart ssh
```    
## Install Sudo
Install the sudo package:  
```
apt install sudo
```  
Add a user to the sudo group:  
```
/usr/sbin/usermod -aG sudo <username>
```  
  
## Configure Sudo  
To configure sudo we have to access the sudoers file.
A command exist in linux to directly edit it: ```visudo```.  
First We can copy and past the path given in the subject in the line below:
```  
Defaults	secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"  
```  
To set the password tries to 3 we copy the following line:
```  
Defaults        passwd_tries=3
```  
To enable the log for the inputs of sudo:
```  
Defaults	log_input
```  
To enable the log for the outputs of sudo:
```  
Defaults	log_output
```  
To set the path where we'll save the logfiles:
```  
Defaults	iolog_dir=/var/log/sudo/
```   
To set the tty as an obligation to use sudo:
```  
Defaults	requiretty
```  
To add a personalized message if the attempt of connection fails:
```  
Defaults	badpass_message="GAME OVER !!!"
```  

## Connect trough SSH:
Open a new terminal in your host machine.  
The basic syntax to connect with ssh is ```ssh username@IP```.  
Since we are not using the default ssh port (22) we'll have to add the flag '-p'.  
The port you will use to connect is the one you configured in VirtualBox Port Forwarding.  
The Ip we'll use is our loopback (127.0.0.1).  
Connecting:  
```
ssh -p 9042 <username>@127.0.0.1
```  

## Install the Uncomplicated Firewall
Install the ufw package:  
```
sudo apt install ufw
```  
Add a rule to allow any connexion to our ssh server:  
```
sudo ufw allow 4242
```  
Enable the firewall:  
```
sudo ufw enable
```  
You can check the firewall status:  
```
sudo ufw status
```  

## Set up a Strong Password Policy
First of all we'll to set up the time of validity of our passwords.  
We can edit the file 'login.defs' for this.  
```
sudo nano /etc/login.defs
```  
To set the password expiring every 30 days we'll edit the line below:  
```PASS_MAX_DAYS   99999``` to this ```PASS_MAX_DAYS   30```  
To set minimum number of days between password changes we'll edit the line below:  
```PASS_MIN_DAYS   0``` to this ```PASS_MIN_DAYS   2```  
To set an alert 7 days before the password expire is in the line below but it's already 7 as default:   
```PASS_WARN_AGE   7```   
   
Then we'll set up the Password strength.  
Install the libpam-pwquality package:  
```  
sudo apt install libpam-pwquality
```  
We can then edit the password strength policy in the config file '/etc/pam.d/common-password'.  
```  
sudo nano /etc/pam.d/common-password
```  
We will edit the line 25 shown below:  
```password        requisite                       pam_pwquality.so retry=3```  
We'll use those options:   
- ```minlen=10``` to specify the len minimum of our password.  
- ```ucredit=-1 dcredit=-1```to require password to have at least 1 uppercase and 1 digit.  
- ```maxrepeat=3``` to set the maximum of repeating characters.  
- ```reject_username``` to check if the username is in the password and reject it in this case.  
- ```difok=7```to check if the new password is different of 7 characters from the old one.  
- ```enforce_for_root``` to set the policy for root.  
We finally get the line below:  
```  
password        requisite                       pam_pwquality.so retry=3 minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root
```  

You'll have to change then the policy for users that already exists (root). 
Change the password of the users that exist to make them respect the new policy:  
```  
passwd
```  
Change the policy for min days, max days and Warning:
```  
sudo chage -m 2 -M 30 -W 7 <username>
```  
