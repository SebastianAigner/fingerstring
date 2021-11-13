#!/bin/bash

# Wait for an incoming POST request on .submitChannel.
# When request comes in, update lasttaken.txt w/ curr date.

SUBMITCHAN=$(cat config.json | jq --raw-output '.submitChannel')

while true
do
    # Run curl in a subshell and pass the results to notify-send
    FOO=$(curl -s https://patchbay.pub/$SUBMITCHAN)
    # Avoid too many requests if server is down or rejecting
    if [ "$?" -ne "0" ]; then
        sleep 1
    fi
    echo "Update endpoint hit."
    echo "$FOO"
    TODAY=$(date '+%Y-%m-%d')
    echo $TODAY > lasttaken.txt
done