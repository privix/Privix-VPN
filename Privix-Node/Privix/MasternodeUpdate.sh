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

####################
# Update the Coin  #
####################
killall -9 altbetd
cd
cd $REPO_NAME
git stash
git pull
cd
sudo chmod -R 755 $REPO_NAME
cd $REPO_NAME
./autogen.sh
./configure --disable-gui-tests --disable-shared --disable-tests --disable-bench --with-unsupported-ssl --with-libressl --with-gui=qt5
make
cd

##################
# Run the daemon #
##################
$DAEMON

watch $CLI getinfo