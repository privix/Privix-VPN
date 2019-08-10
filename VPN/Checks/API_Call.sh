#!/bin/bash
# Copyright (c) 2019 Privix. Released under the MIT License.

MNSTAT=$(curl -v "https://explorer.privix.io/api/masternode/${MNADDY}" | jq ".mns.status")