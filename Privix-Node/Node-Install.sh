#!/bin/bash
# Copyright (c) 2019 Privix. Released under the MIT License.

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=6
BACKTITLE="VPX Setup Wizard"
TITLE="VPX VPS Setup"
MENU="Choose one of the following options:"

OPTIONS=(1 "Install Privix Daemon"
		 2 "Install Privix Masternode"
		 3 "Update Privix Daemon and CLI"
         4 "Exit"
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
        1) # Daemon
		cd Daemon
		bash daemon-install.sh
        ;;
	    
        2) # Masternode
		cd Masternode
		bash masternode-install.sh
		;;

		3) # Update Daemon and CLI
		cd Update
		bash update-install.sh
		;;

		4) # Back to main menu
		exit 1
		;;

esac