#!/bin/bash
# Copyright (c) 2019 Privix. Released under the MIT License.

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logs CronJob.
LOG_FILE="/etc/openvpn/cronjob_log.txt"
LOGTIME=`date "+%Y-%m-%d %H:%M:%S"`
EXTIP="$(ip route get 1 | awk '{print $NF;exit}')"


echo -e "${GREEN}Creating Crontab Entry${GREEN}"
echo  "*/5 * * * * cd privix-vpn/VPN/Checks/Active_Check.sh 2>&1" > /root/activ_check.cron
crontab /root/activ_check.cron
rm /root/activ_check.cron.cron >/dev/null 2>&1
echo -e ${LOGTIME} " : User ${GREEN}${USER}${NC} on vps ${BLUE}${EXTIP}${NC} just created activ_check cronjob." >> ${LOG_FILE}