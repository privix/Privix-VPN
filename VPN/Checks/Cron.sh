#!/bin/bash
# Copyright (c) 2019 Privix. Released under the MIT License.

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logs CronJob.
LOG_FILE="/etc/privix/mn_check_log.txt"
LOGTIME=`date "+%Y-%m-%d %H:%M:%S"`
EXTIP="$(ip route get 1 | awk '{print $NF;exit}')"
CRON_PATH="/etc/privix/mn_cron.cron"


    echo -e "${GREEN}Creating Crontab Entry${NC}"
	echo  "*/10 * * * * cd privix-vpn/Checks/active_check.sh" >> $CRON_PATH
	crontab $CRON_PATH
	echo -e ${LOGTIME} " : User ${GREEN}${USER}${NC} on vps ${BLUE}${EXTIP}${NC} has just created the CronJob." >> ${LOG_FILE}
		cd -
	fi
