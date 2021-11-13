#!/bin/bash

TOKEN=$(cat config.json | jq --raw-output '.pushover.token')
USER=$(cat config.json | jq --raw-output '.pushover.user')
MESSAGE=$(cat config.json | jq --raw-output '.pushover.notificationMessage')
PAGECHAN=$(cat config.json | jq --raw-output '.pageChannel')

DATE=`cat lasttaken.txt`
TODAY=$(date '+%Y-%m-%d')
if [ $TODAY == $DATE ]; then
    exit 0    
fi

echo "NOTIFY"

curl --location --request POST 'https://api.pushover.net/1/messages.json' \
--form 'token="'"$TOKEN"'"' \
--form 'user="'"$USER"'"' \
--form 'message="'"$MESSAGE"'"' \
--form 'url="https://patchbay.pub/'"$PAGECHAN"'"'