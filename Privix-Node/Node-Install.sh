#!/bin/bash
# Copyright (c) 2019 Privix. Released under the MIT License.

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=6
BACKTITLE="VPX Setup Wizard"
TITLE="VPX VPS Setup"
MENU="Choose one of the following options:"

OPTIONS=(1 "Install Privix Masternode"
		 2 "Update Privix Masternode"
		 3 "Compile Privix Windows Wallet"
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
        1) # Masternode Install
		cd Privix
		bash MasternodeInstall.sh
        ;;
	    
        2) # Masternode Update
		cd Privix
		bash MasternodeUpdate.sh
		;;

		3) # Compile Win Wallet
		cd Update
		bash WindowsCompile.sh
		;;

		4) # Back to main menu
		exit 1
		;;

esac