#!/bin/bash

#############################################################
#							    							#
# Script   : Fast_Flux.sh				    				#
# Function : Demonstrate Single Fast Flux	   	    		#
#	     					            					# 
# Coded By : Shubham Tandlekar			            		#
# 						  	    							#
#############################################################
clear
echo " "
echo "$(tput setaf 3)[+] $(tput setaf 2) Starting to ping bots"
echo " "


DIR="/var/named"

# Pool of IPs ( Reverse Proxy Servers/Infected Hosts/Bots )
declare -a IPPOOL=("IP1" "IP2")

#Old IP which will be chaged after certain amount of time
OLD_IP=$(dig +short Domain.com)

is_alive_ping()
{
  ping -c 1 $1 > /dev/null
  
	if [ $? -eq 0 ] 
	then
		return 0
	else
		return 1

	fi
}

counter=0
for i in "${IPPOOL[@]}"

	do
	ping -q -c1 $i > /dev/null

	if [ $? -eq 0 ];
	then
		echo "$(tput setaf 3)[+] $(tput setaf 2) $i is up!"
		echo " "
		echo "$(tput setaf 3)[+] $(tput setaf 2) Old IP : $OLD_IP"
		echo " "
		
		#grep -E -o "((('Domain.com.	')
		#OLD_IP=grep "/((Domain\.com\.)(\t)(300)(\t)(IN)(\t)(A)(\t))((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))/g" Domain.com.db
		
		#in cPanel Systems, the Zone Records are saved in /Var/Named directory
		# So going and changing all the A entries of the domain asked.
		
		sed -i "s/"$OLD_IP"/"$i"/g" $DIR/Domain.com.db
		echo "$(tput setaf 3)[+] $(tput setaf 2) A Entry has been changed to $i IP"
		tput setaf 7
		echo " "
		break
	else
		#If the Host is down, remove the entry from the IP Pool
		# Yes, this will not work in this case, as I will be calling the script everytime. In real world, there will be two scripts, one for IP Pool and one for executions ( or a seperate function ) 
		unset IPPOOL[counter]
		continue
	fi
	
	counter=counter+1
done




