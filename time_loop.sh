#!/bin/bash

# clean log file
:>log.log

header="time; RPM; PWM; battery; temp1; temp2"
echo $header >> log.log


function finish {
  rm -rf "$FILE"
  echo Exit
}
trap finish EXIT

x=1
FILE=quit
while [ ! -f $FILE ]
do
    echo "Welcome 5x times"
    date +%T >> log.log
    echo $x >> log.log
    sleep 1
    x=$(( $x + 1)) 
done
