#!/bin/bash
# Copyright (c) 2019 Privix. Released under the MIT License.

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logs When ran.
LOG_FILE="/etc/privix/active_check.txt"
LOGTIME=`date "+%Y-%m-%d %H:%M:%S"`
EXTIP="$(ip route get 1 | awk '{print $NF;exit}')"

MNADDY=$(</etc/openvpn/payment_address.txt)
MNSTAT=$(</etc/openvpn/masternode_status.txt)

    echo "${GREEN}Checking Masternode Status${NC}"

	if [[ $MNSTAT == "ENABLED" ]]; then
		echo -e ${LOGTIME} " : User ${GREEN}${USER}${NC} on vps ${BLUE}${EXTIP}${NC} has provided ${GREEN}${MNADDY}${NC} as their masternode address with a node status of: ${GREEM}${MNSTAT}${NC}." >> ${LOG_FILE}
        sleep 5
		exit 1
        fi
    else
    do 
		echo -e ${LOGTIME} " : User ${GREEN}${USER}${NC} on vps ${BLUE}${EXTIP}${NC} has provided ${GREEN}${MNADDY}${NC} as their masternode address with a node status of: ${GREEM}${MNSTAT}${NC}." >> ${LOG_FILE}
			rm -rf /etc/privix/mn_cron.cron
			systemctl stop privix-vpn-server
				echo "Masternode is not ENABLED"
				echo "Cron Job has been deleted"
				echo "Stopping Privix Masternode & VPN Service"
    exit 0
fi