#!/bin/bash

echo Executing updown.sh with type: $script_type and params: $@

if [ $script_type = "down" ]; then
  echo "Killing transmission-daemon ..." 
  pkill -f transmission-daemon
  exit $?
fi

su - app -s /bin/bash -c \
  "transmission-daemon \
    --foreground \
    --config-dir /transmission \
    --bind-address-ipv4 $4" &

echo "Finished updown.sh execution"