#!/bin/bash
# Copyright (c) 2019 Privix. Released under the MIT License.

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logs for proof of Terms of Service.
#LOG_FILE="/etc/openvpn/terms_log.txt"
LOG_FILE="/etc/openvpn/terms_log.txt"
LOGTIME=`date "+%Y-%m-%d %H:%M:%S"`
EXTIP="$(ip route get 1 | awk '{print $NF;exit}')"

HEIGHT=15
WIDTH=50
CHOICE_HEIGHT=6
BACKTITLE="Terms Check"
TITLE="VPX VPN Terms And Condidtions"
MENU="Do You Accept The Terms and conditions provided by privix.io?"

OPTIONS=(1 "Proceed to read Terms of Service"
		 2 "Yes Proceed without reading"
		 3 "Yes I have already read the Terms of Service"
		 4 "No"
)

CHOICE=$(whiptail --clear\
		--backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
clear

case $CHOICE in
        1) # Read the terms of service docoument
		cd
		cat privix-vpn/Docs/Temp_Terms_of_Service/Terms.md

		# Ask user if they accept after reading Terms of Service.
		echo -e "Do you Accept the Terms of Serivce? ${GREEN}Y${NC} or ${RED}N${NC}"		
		read USER_INPUT
		
		if [ $USER_INPUT == "Y" ] ||
		   [ $USER_INPUT == "y" ]; then
		    echo -e "Please input your ${GREEN}Masternode Payment Address${NC} you generated for this masternode install, this will be used to verify you are the owner of the masternode."
		read MNADDY	
		echo "$MNADDY" > /etc/openvpn/payment_address.txt
		sleep 10
		# Check if node is active or not to move forward.
		bash Active_Check.sh
		# Add source to get the curl command talking to explorer api
		source ./API_Call.sh
			echo -e ${LOGTIME} " : User ${GREEN}${USER}${NC} on vps ${BLUE}${EXTIP}${NC} has provided ${GREEN}${MNADDY}${NC} as their masternode address with status ${GREEM}${MNSTAT}${NC} and has finished reading the Terms of Service and has choosen to proceed to install the VPN on this server." >> ${LOG_FILE}

			## Create the cronjob
			echo -e ${LOGTIME} " : User ${GREEN}${USER}${NC} on vps ${BLUE}${EXTIP}${NC} has just finished setting up the privixvpn and is moving to run the cron job setup." >> ${LOG_FILE}
			bash Cron.sh
		cd
			bash privix-vpn/VPN/VPN_Selection_Install.sh
		elif [ $USER_INPUT == "N" ] ||
			 [ $USER_INPUT == "n" ]; then 
		echo ${LOGTIME} " : User ${GREEN}${USER}${NC} on vps ${BLUE}${EXTIP}${NC} has provided ${GREEN}${MNADDY}${NC} as their masternode address with status ${GREEM}${MNSTAT}${NC} and has finished reading the Terms of Service and choosen not to install the VPN on this server." >> ${LOG_FILE}
			 exit 1
		fi
        ;;

		2) # Yes move to vpn selection
		echo ${GREEN}Please input your Masternode payment address you generated for this masternode install, this will be used to verify you are the owner of the masternode.${GREEN}
		read MNADDY
		echo ${LOGTIME} " : User ${GREEN}${USER}${NC} on vps ${BLUE}${EXTIP}${NC} has choosen to Proceed without reading"  >> ${LOG_FILE}
		cd
		bash privix-vpn/VPN/VPN_Selection_Install.sh		 
        ;;

		3) # Yes i have already read the terms of service
		echo ${LOGTIME} " : User ${GREEN}${USER}${NC} on vps ${BLUE}${EXTIP}${NC} has choosen they have already read the Terms of Service"  >> ${LOG_FILE}
		cd
		bash privix-vpn/VPN/VPN_Selection_Install.sh		 
        ;;
	    
        4) # No Exit
		echo ${LOGTIME} " : User ${GREEN}${USER}${NC} on vps ${BLUE}${EXTIP}${NC} ${RED}No${NC}" >> ${LOG_FILE}
		exit 1
		;;
esac