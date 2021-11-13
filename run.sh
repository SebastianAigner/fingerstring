#!/bin/bash
trap 'trap - SIGTERM && kill -- -$$' SIGINT SIGTERM EXIT # https://stackoverflow.com/a/2173421

./serve.sh &
./update.sh &

wait