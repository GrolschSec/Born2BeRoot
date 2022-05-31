#!/bin/bash

lvm_check(){
	if [ "$(lsblk | grep 'lvm' | wc -l)" -eq 0 ];
	then 
		echo 'No';
	else 
		echo "Yes";
	fi;
}

memusage(){
	total=$(free -m | awk 'NR==2' | tr -s " " | cut -f 2 -d " ")
	used=$(free -m | awk 'NR==2' | tr -s " " | cut -f 3 -d " ")
	res=$(free -m | awk 'NR==2' |tr -s " " | cut -f2- -d " " | awk '{ printf("%.2f"), $2/$1*100 }')
	echo "$used/$total MB ($res%)"
}

wall \
$'#Architecture:' `uname -a` \
$'\n#CPU Physical:' `cat /proc/cpuinfo | grep "processor" | wc -l` \
$'\n#vCPU:' `cat /proc/cpuinfo | grep "processor" | wc -l` \
$'\n#Memory Usage:' `memusage` \
$'\n#Disk Usage:' `echo $(df -h | awk '$NF=="/"{printf "%d/%dGB (%s)", $3,$2,$5}')` \
$'\n#CPU Load:' `top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf("%.1f%%"), $1 + $3}'` \
$'\n#Last boot:' `who -b | tr -s " " | cut -d " " -f3- | cut -d " " -f2-` \
$'\n#LVM Use:' `lvm_check` \
$'\n#Connexions TCP:' `netstat -antp | grep ESTABLISHED | wc -l` $'ESTABLISHED' \
$'\n#User log:' `who | wc -l` \
$'\n#Network: IP' `ip a | grep inet | grep -v inet6 | grep -v "host" | tr -s " " | cut -d " " -f 3 | cut -f 1 -d '/'`$' ('`ip a  | grep link/ether | tr -s " " | cut -f 3 -d " "`$')'\
$'\n#Sudo:' `cat /var/log/auth.log | grep sudo | wc -l`