#!/bin/bash
# Copyright (c) 2019 Privix. Released under the MIT License.

source Terms_Check.sh
sudo install install jq

RED='\033[0;31m'
GREEN='\033[0;32m'
MNSTAT=$(curl -v "https://explorer.privix.io/api/masternode/${MNADDY}" | jq ".mns.status")

    echo "${GREEN}Creating Crontab Entry${GREEN}"
echo  "*/5 * * * * cd /root/active_check.sh 2>&1" > /root/activ_check.cron
crontab /root/activ_check.cron
rm /root/activ_check.cron.cron >/dev/null 2>&1
cd -
exit 1
fi
    
    echo "${GREEN}Checking Masternode Status${GREEN}"

if [ $MNSTAT == "ENABLED" ]; then
        exit 1
        fi
    else  
        systemctl stop privix.service
        systemctl stop openvpn@openvpn-server
        echo "Masternode is not ENABLED"
        echo "Stopping Privix Masternode & VPN Service"
    exit 0
fi