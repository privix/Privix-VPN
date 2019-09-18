#!/bin/bash
# Copyright (c) 2019 Privix. Released under the MIT License.

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=6
BACKTITLE="VPX VPN Setup Wizard"
TITLE="VPX VPN Setup"
MENU="Choose from below: Node must be running on this server!"

OPTIONS=(1 "ipsec"
		 2 "pptp"
		 3 "privixvpn"
         4 "exit"
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
        1) # ipsec
		cd
		cd privix-vpn/VPN/ipsec
		bash IPSEC_Install_Menu.sh
        ;;
	    
        2) # pptp
		cd
		cd privix-vpn/VPN/pptp
		bash PPTP_Install_Menu.sh
		;;

		3) # privixvpn
		cd
		cd privix-vpn/VPN/privixvpn
		bash Privix_Install_Menu.sh
		;;

		4) # Exit Script
		exit 1
		;;

esac