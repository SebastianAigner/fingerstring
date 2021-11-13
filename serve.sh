#!/bin/bash

PAGECHANNEL=$(jq <config.json --raw-output '.pageChannel')
SUBMITCHANNEL=$(jq <config.json --raw-output '.submitChannel')
echo "Running on https://patchbay.pub/$PAGECHANNEL"

while true; do
  DATE=$(cat lasttaken.txt)
  sed -e "s/\${date}/$DATE/" -e "s/\${url}/$SUBMITCHANNEL/" template.html >./compiled.html
  if ! curl -X POST https://patchbay.pub/"$PAGECHANNEL" --data-binary @compiled.html; then
    # Avoid too many requests if server is down or rejecting
    sleep 1
  fi
done
