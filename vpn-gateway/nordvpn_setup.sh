#!/usr/bin/env bash

sh <(wget -qO - https://downloads.nordcdn.com/apps/linux/install.sh)
nordvpn whitelist add subnet 192.168.1.0/24
nordvpn set dns 103.86.96.100 103.86.99.100
nordvpn set technology nordlynx
nordvpn set autoconnect on
nordvpn settings
