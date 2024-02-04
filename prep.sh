#!/bin/bash

usage() { 
    echo "Usage: $0 ..." 1>&2; exit 1; 
}

input='../TRACE.cgns'
freq=900
output='out.cgns'
while getopts "hi:f:o:" opt; do
    case $opt in
        i ) input=$OPTARG;;
        f ) freq=$OPTARG;;
        o ) output=$OPTARG;;
        h ) usage
        exit 0;;
        *) usage
        exit 1;;
    esac
done
echo "-i $input"
echo "-f $freq"
echo "-o $output"
