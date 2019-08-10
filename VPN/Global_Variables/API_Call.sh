#!/bin/bash
# Copyright (c) 2019 Privix. Released under the MIT License.

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logs API Call.
LOG_FILE="/etc/openvpn/api_call_log.txt"
LOGTIME=`date "+%Y-%m-%d %H:%M:%S"`
EXTIP=`curl -s4 icanhazip.com`

MNADDY=$(</etc/openvpn/payment_address.txt)
# Only used for testing logs.
#echo -e ${LOGTIME} " : ${MNADDY}" >> ${LOG_FILE}
MNSTAT=$(curl -v "https://explorer.privix.io/api/masternode/${MNADDY}" | jq ".mns.status")
# Only used for testing logs.
#echo -e ${LOGTIME} " : ${MNSTAT}" >> ${LOG_FILE}

if [ $MNSTAT == "ENABLED" ]; then
# Make the logfile input for ENABLED
echo -e ${LOGTIME} " : User ${GREEN}${USER}${NC} on vps ${BLUE}${EXTIP}${NC} has provided ${GREEN}${MNADDY}${NC} as their masternode address with a node status of: ${GREEM}${MNSTAT}${NC}." >> ${LOG_FILE}

else
# Make the logfile input for anything else
echo -e ${LOGTIME} " : User ${GREEN}${USER}${NC} on vps ${BLUE}${EXTIP}${NC} has provided ${RED}${MNADDY}${NC} as their masternode address with a node status of: ${RED}${MNSTAT}${NC}." >> ${LOG_FILE}

fi