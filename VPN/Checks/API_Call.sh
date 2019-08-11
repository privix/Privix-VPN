#!/bin/bash
# Copyright (c) 2019 Privix. Released under the MIT License.

sudo install install jq

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logs API Call.
LOG_FILE="/etc/openvpn/api_call_log.txt"
LOGTIME=`date "+%Y-%m-%d %H:%M:%S"`
EXTIP="$(ip route get 1 | awk '{print $NF;exit}')"

MNADDY=$(</etc/openvpn/payment_address.txt)

MNSTAT=$(curl -v "https://explorer.privix.io/api/masternode/${MNADDY}" | jq ".mns.status")

# Make the status log fresh each time for a correct status
sudo rm -rf /etc/openvpn/masternode_status.txt
# Strip the head and tail characters
MNSTATUS=${MNSTAT:1:7}
# Output the current Status
echo "${MNSTATUS}" > /etc/openvpn/masternode_status.txt

if [[ $MNSTATUS == "ENABLED" ]]; then
# Make the logfile input for ENABLED
echo -e ${LOGTIME} " : User ${GREEN}${USER}${NC} on vps ${BLUE}${EXTIP}${NC} has provided ${GREEN}${MNADDY}${NC} as their masternode address with a node status of: ${GREEN}${MNSTATUS}${NC}." >> ${LOG_FILE}

else
# Make the logfile input for anything else
echo -e ${LOGTIME} " : User ${GREEN}${USER}${NC} on vps ${BLUE}${EXTIP}${NC} has provided ${GREEN}${MNADDY}${NC} as their masternode address with a node status of: ${RED}${MNSTATUS}${NC}." >> ${LOG_FILE}

fi