#!/bin/bash
# Copyright (c) 2019 Privix. Released under the MIT License.

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=6
BACKTITLE="VPX Setup Wizard"
TITLE="VPX VPS Setup"
MENU="Choose one of the following options:"

OPTIONS=(1 "Go To Privix Daemon / MasterNode Setup"
		 2 "Install VPN"
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
        1)	# Privix Node Related	
		cd Privix-Node
		bash Node-Install.sh
        ;;
	    
        2)  # Privix VPN Related
		mkdir /etc/privix/
		cd VPN/Checks
		bash Terms_Check.sh	
		;;
esac