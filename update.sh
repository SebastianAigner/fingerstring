#!/bin/bash

# Wait for an incoming POST request on .submitChannel.
# When request comes in, update lasttaken.txt w/ curr date.

SUBMITCHANNEL=$(jq <config.json --raw-output '.submitChannel')

while true; do
  if ! curl -s https://patchbay.pub/"$SUBMITCHANNEL"; then
    # Avoid too many requests if server is down or rejecting
    sleep 1
    continue
  fi
  echo "Update endpoint hit."
  TODAY=$(date '+%Y-%m-%d')
  echo "$TODAY" >lasttaken.txt
done
