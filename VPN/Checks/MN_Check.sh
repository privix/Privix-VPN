#!/bin/bash
# Copyright (c) 2019 Privix. Released under the MIT License.

source ./API_Call.sh
sudo install install jq

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logs API Call.
LOG_FILE="/etc/openvpn/mn_check_log.txt"
LOGTIME=`date "+%Y-%m-%d %H:%M:%S"`
EXTIP="$(ip route get 1 | awk '{print $NF;exit}')"

MNADDY=$(</etc/openvpn/payment_address.txt)
MNSTAT=$(</etc/openvpn/masternode_status.txt)

    echo -e "${GREEN}Creating Crontab Entry${GREEN}"
	echo  "*/5 * * * * cd /root/active_check.sh 2>&1" > /root/activ_check.cron
		crontab /root/activ_check.cron
		rm /root/activ_check.cron.cron >/dev/null 2>&1
		exit 1
	fi
    
    echo "${GREEN}Checking Masternode Status${NC}"

if [[ $MNSTAT == "ENABLED" ]]; then
echo -e ${LOGTIME} " : User ${GREEN}${USER}${NC} on vps ${BLUE}${EXTIP}${NC} has provided ${GREEN}${MNADDY}${NC} as their masternode address with a node status of: ${GREEM}${MNSTAT}${NC}." >> ${LOG_FILE}
        exit 1
        fi
    else  
	echo -e ${LOGTIME} " : User ${GREEN}${USER}${NC} on vps ${BLUE}${EXTIP}${NC} has provided ${GREEN}${MNADDY}${NC} as their masternode address with a node status of: ${GREEM}${MNSTAT}${NC}." >> ${LOG_FILE}
        systemctl stop privix.service
        systemctl stop openvpn@openvpn-server
        echo "Masternode is not ENABLED"
        echo "Stopping Privix Masternode & VPN Service"
    exit 0
fi