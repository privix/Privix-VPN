#!/bin/bash
# Copyright (c) 2019 Privix. Released under the MIT License.

RED='\033[0;31m'
GREEN='\033[0;32m'

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=6
BACKTITLE="VPX Setup Wizard"
TITLE="VPX VPS Setup"

# Ask user if they would like to install the vpn software after node install.
MENU="Would You like to install the VPN Client as well?"

OPTIONS=(1 "Yes"
		 2 "No"
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
        1)	# VPN Selection Install Script	
		cd 
		cd privix-vpn/VPN/Checks
		bash Terms_Check.sh
        ;;
	    
        2)  # Exit
		echo Vpx configuration file created successfully. 
		echo Vpx Server Started Successfully using the command ./privixd -daemon
		echo If you get a message asking to rebuild the database, please hit Ctr + C and run ./privixd -daemon -reindex
		echo If you still have further issues please reach out to support in our Discord channel. 
		echo Please use the following Private Key when setting up your wallet: $GENKEY
		exit 0
		;;
esac