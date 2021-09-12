#!/bin/bash
# Example for optional parameter handed over by flags
# 
# -w 
# Sets the value for PWM, which is by default 48  
# 
# -n 
# Sets the name of the outfile, which is by default "runtime.csv"
# 
# :)
# if any flag is triggered without argument, case ":)" is called

# default-values:
PWM=48
FILENAME="runtime.csv"

while getopts ":w:n:" flag; do
  case $flag in
    w) PWM=${OPTARG} ;;
    n) FILENAME=${OPTARG} ;;
    \?)
      echo "Invalid option: -${OPTARG}" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

echo "PWM is $PWM"
echo "filename is $FILENAME"
