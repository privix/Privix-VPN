#!/bin/bash
# Copyright (c) 2019 Node_Install. Released under the MIT License.

RPC_PORT=7789
COIN_PORT=7788
COIN_NAME='Privix'
REPO_NAME='privix-core'
COIN_DAEMON='privixd'
COIN_CLI='privix-cli'
COIN_QT='privix-qt'
GITHUB=https://github.com/privix/privix-core

COIN_PATH=/root/.$REPO_NAME
DAEMON_PATH=$REPO_NAME/src/$COIN_DAEMON
CLI_PATH=$REPO_NAME/src/$COIN_CLI

DEPENDS_PATH="privix-vpn/Depends/"
DEPENDS_SCRIPT="install.sh"
EXTIP=`curl -s4 icanhazip.com`
RPCUSER=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
RPCPASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)