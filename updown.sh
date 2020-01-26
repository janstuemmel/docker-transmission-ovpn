#!/bin/bash

echo Executing up.sh with type: $script_type and params: $@

if [ $script_type = "down" ]; then
  echo Killing transmission-daemon ... 
  pkill -f transmission-daemon
  exit 0
fi

su - app -s /bin/bash -c "transmission-daemon \
  --foreground \
  --config-dir /transmission \
  --download-dir /downloads \
  --bind-address-ipv4 $4 \
  --no-portmap \
  --peerport $TRANSMISSION_PEER_PORT \
  --no-auth \
  --allowed *.*.*.*" \
  &

