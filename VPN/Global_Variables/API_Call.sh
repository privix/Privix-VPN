#!/bin/bash
# Copyright (c) 2019 Privix. Released under the MIT License.

MNADDY=' cat etc/openvpn/payment_address.txt'
MNSTAT=$(curl -v "https://explorer.privix.io/api/masternode/${MNADDY}" | jq ".mns.status")