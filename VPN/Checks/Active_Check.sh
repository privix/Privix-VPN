#!/bin/bash
# Copyright (c) 2019 Privix. Released under the MIT License.

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

LOG_FILE="/etc/openvpn/active_check.txt"
LOGTIME=`date "+%Y-%m-%d %H:%M:%S"`
EXTIP="$(ip route get 1 | awk '{print $NF;exit}')"
MNADDY=$(</etc/openvpn/payment_address.txt)
MNSTAT=$(curl -v "https://explorer.privix.io/api/masternode/${MNADDY}" | jq ".mns.status")
STATUS=${MNSTAT}
# Strip the head and tail characters
MNSTATUS=${MNSTAT:1:7}

    echo "${GREEN}Checking Masternode Status${NC}"
	
	#if [[ $MNSTATUS == $STATUS ]]; then
	if [[ $MNSTATUS == "ENABLED" ]]; then
		echo -e ${LOGTIME} " : User ${GREEN}${USER}${NC} on vps ${BLUE}${EXTIP}${NC} has provided ${GREEN}${MNADDY}${NC} as their masternode address with a node status of: ${GREEM}${MNSTATUS}${NC} and will allow the VPN to keep running." >> ${LOG_FILE}
    else 
		echo -e ${LOGTIME} " : User ${GREEN}${USER}${NC} on vps ${BLUE}${EXTIP}${NC} has provided ${GREEN}${MNADDY}${NC} as their masternode address with a node status of: ${GREEM}${MNSTATUS}${NC} and will stop the VPN service because node is not running." >> ${LOG_FILE}
			rm -rf /root/activ_check.cron
			systemctl stop privix.service
			systemctl stop openvpn@openvpn-server
				echo "Masternode is not ENABLED"
				echo "Cron Job has been deleted"
				echo "Stopping Privix Masternode & VPN Service"
    exit 0
fi