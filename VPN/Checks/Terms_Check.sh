#!/bin/bash
# Copyright (c) 2019 Privix. Released under the MIT License.

# The only user logs will be captured in this script for proof of Terms of Service.

LOG_FILE="/etc/openvpn/terms_log.txt"
LOGTIME=`date "+%Y-%m-%d %H:%M:%S"`
EXTIP=`curl -s4 icanhazip.com`

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=6
BACKTITLE="Terms Check"
TITLE="VPX VPN Terms And Condidtions"
MENU="Do You Accept The Terms and conditions here: privix.io"

OPTIONS=(1 "Yes Proceed to read Terms of Service"
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
        1) # Yes read the terms of service docoument
		echo ${LOGTIME} " : User ${USER} on vps ${EXTIP} has choosen to Proceed to read Terms of Service before VPN Install" >> ${LOG_FILE}
		cd
		cat privix-vpn/Docs/Temp_Terms_of_Service/Terms.md

		# Ask user if they accept after reading Terms of Service.
		echo "Do you Accept the Terms of Serivce? Y or N"		
		read USER_INPUT
		
		if [ $USER_INPUT == "Y" ] ||
		   [ $USER_INPUT == "y" ]; then
		   echo ${LOGTIME} " : User ${USER} on vps ${EXTIP} has finished reading the Terms of Service and has choosen to proceed to install the VPN on this server." >> ${LOG_FILE}
		cd
		bash privix-vpn/VPN/VPN_Selection_Install.sh
		elif [ $USER_INPUT == "N" ] ||
			 [ $USER_INPUT == "n" ]; then 
		echo ${LOGTIME} " : User ${USER} on vps ${EXTIP} has finished reading the Terms of Service and choosen not to install the VPN on this server." >> ${LOG_FILE}
			 exit 1
		fi
        ;;

		2) # Yes move to vpn selection
		echo ${LOGTIME} " : User ${USER} on vps ${EXTIP} has choosen to Proceed without reading"  >> ${LOG_FILE}
		cd
		bash privix-vpn/VPN/VPN_Selection_Install.sh		 
        ;;

		3) # Yes i have already read the terms of service
		echo ${LOGTIME} " : User ${USER} on vps ${EXTIP} has choosen they have already read the Terms of Service"  >> ${LOG_FILE}
		cd
		bash privix-vpn/VPN/VPN_Selection_Install.sh		 
        ;;
	    
        4) # No Exit
		echo ${LOGTIME} " : User ${USER} on vps ${EXTIP} No" >> ${LOG_FILE}
		exit 1
		;;
esac