#!/bin/bash
# Copyright (c) 2019 Privix. Released under the MIT License.

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=6
BACKTITLE="VPX PPTP VPN Setup Wizard"
TITLE="VPX PPTP VPN Setup"
MENU="Choose which Action to perform!"

OPTIONS=(1 "New PPTP VPN Install"
		 2 "Add Another User"
		 3 "Delete User"
         4 "Check A User Login"
		 5 "Backup Existing VPN"
		 6 "Turn Auto Start VPN On"
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
        1) # New Install of pptp VPN
		bash install.sh
        ;;
	    
        2) # Add another user
		bash adduser.sh
		;;

		3) # Delete A User
		bash deluser.sh
		;;

		4) # Check a user login
		bash checkuser.sh
		;;

		5) # Backup Existing VPN
		bash backup.sh
		;;

		6) # Turn Autostart VPN On
		bash autostart.sh
		;;

esac