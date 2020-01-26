#!/bin/bash

OVPN_CONFIG=${OVPN_CONFIG:-`ls *.ovpn | shuf -n 1`}
TRANSMISSION_PEER_PORT=${TRANSMISSION_PEER_PORT:-51413}

echo Using openvpn config file: $OVPN_CONFIG

openvpn \
  --config $OVPN_CONFIG \
  $@ \
  --script-security 2 \
  --up-delay \
  --setenv TRANSMISSION_PEER_PORT $TRANSMISSION_PEER_PORT \
  --up    /usr/local/bin/updown.sh \
  --down  /usr/local/bin/updown.sh \
  --up-restart