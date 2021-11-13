CHANNEL=$(cat config.json | jq --raw-output '.pageChannel')
SUBMITCHAN=$(cat config.json | jq --raw-output '.submitChannel')
echo "Running on https://patchbay.pub/$CHANNEL"

while true; do
    DATE=`cat lasttaken.txt`
    sed -e "s/\${date}/$DATE/" -e "s/\${url}/$SUBMITCHAN/" template.html > ./compiled.html
    curl -X POST https://patchbay.pub/$CHANNEL --data-binary @compiled.html;
done