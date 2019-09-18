#!/bin/bash
# Copyright (c) 2019 Node_Install. Released under the MIT License.

###############
# Colors Keys #
###############
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

############################
# Bring in the coins specs #
############################
source ./specs.sh

###################
# Install Depends #
###################
cd
cd $DEPENDS_PATH
bash LinuxDepends.sh
clear
echo VPS Server prerequisites installed.

#################################
# Make sure firewall is opened. #
#################################
  echo -e "Installing and setting up firewall to allow ingress on port ${GREEN}$COIN_PORT${NC}"
  ufw allow $COIN_PORT/tcp comment "$COIN_NAME MN port" >/dev/null
  ufw allow ssh comment "SSH" >/dev/null 2>&1
  ufw limit ssh/tcp >/dev/null 2>&1
  ufw default allow outgoing >/dev/null 2>&1
  echo "y" | ufw enable >/dev/null 2>&1

####################
# Compile the Coin #
####################
cd
git clone $GITHUB
sudo chmod -R 755 $REPO_NAME
cd $REPO_NAME
./autogen.sh
./configure --disable-gui-tests --disable-shared --disable-tests --disable-bench --with-unsupported-ssl --with-libressl --with-gui=qt5
make
cd

##############################
# Masternode Genkey Creation #
##############################
  echo -e "Enter your ${RED}$COIN_NAME Masternode Private Key${NC}. Leave it blank to generate a new ${RED}Masternode Private Key${NC} for you:"
  read -e COINKEY
  if [[ -z "$COINKEY" ]]; then
  $DAEMON -daemon
  sleep 30
  if [ -z "$(ps axo cmd:100 | grep $DAEMON)" ]; then
   echo -e "${RED}$COIN_NAME server couldn not start. Check /var/log/syslog for errors.{$NC}"
   exit 1
  fi
  COINKEY=$($CLI masternode genkey)
  if [ "$?" -gt "0" ];
    then
    echo -e "${RED}Wallet not fully loaded. Let us wait and try again to generate the Private Key${NC}"
    sleep 30
    COINKEY=$($CLI masternode genkey)
  fi
  $CLI stop
fi
clear

##########################
# Create the Config file #
##########################
mkdir $COIN_PATH/ && touch $COIN_PATH/$REPO_NAME.conf
cat << EOF > $COIN_PATH/$REPO_NAME.conf

 listen=1
 server=1
 daemon=1
 staking=0
 rpcuser=testuser
 rpcpassword=testpassword
 rpcallowip=127.0.0.1
 rpcbind=127.0.0.1
 maxconnections=24
 masternode=1
 masternodeprivkey=$COINKEY
 bind=$EXTIP
 externalip=$EXTIP
 masternodeaddr=$EXTIP:$COIN_PORT

EOF
clear

##################
# Run the daemon #
##################
$DAEMON

watch $CLI getinfo