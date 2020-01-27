#!/bin/bash

OVPN_CONFIG=${OVPN_CONFIG:-`ls *.ovpn | shuf -n 1`}

echo Using openvpn config file: $OVPN_CONFIG

# transmission default settings
(cd /transmission && dockerize -template settings.json.tmpl:settings.json)

openvpn \
  --config $OVPN_CONFIG \
  $@ \
  --script-security 2 \
  --up-delay \
  --up    /usr/local/bin/updown.sh \
  --down  /usr/local/bin/updown.sh \
  --up-restart