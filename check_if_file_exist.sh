#!/bin/bash

# this function will be called by any EXIT signal
function finish {
  rm -rf "$FILENAME"
  echo Exit
}
trap finish EXIT

i=1
dt=2
FILENAME=quit

echo "Press ctr-c to kill or touch quit"

while [ ! -f $FILENAME ]
do
    echo "counter: i=$i, time=$(date +%T), File: ${FILENAME} doesn't exist"
    sleep $dt
    i=$(( $i + 1)) 
done

echo "$FILENAME is detected and routine finished" 
