#!/bin/bash

set -e

echo "Hi there" > backup.dump

mkdir -p daily weekly monthly yearly


function backup {

    dayOfYear=$1
    dayOfMonth=$2
    dayOfWeek=$3
    monthOfYear=$4

    if (( $dayOfYear == 1 )); then
        timestamp=$(date --iso-8601=seconds)
        mv backup.dump yearly/$timestamp.dump 
    elif (( $dayOfMonth == 1 )); then
        mv backup.dump monthly/$monthOfYear.dump 
    elif (( $dayOfMonth == 8 )); then
        mv backup.dump weekly/1.dump 
    elif (( $dayOfMonth == 15 )); then
        mv backup.dump weekly/2.dump 
    elif (( $dayOfMonth == 22 )); then
        mv backup.dump weekly/3.dump 
    else
        mv backup.dump daily/$dayOfWeek.dump
    fi
}

if [[ $# -eq 0 ]]; then
    dayOfYear=$(date +%-j)
    dayOfMonth=$(date +%-d)
    dayOfWeek=$(date +%-u)
    monthOfYear=$(date +%-m)

    backup $dayOfYear $dayOfMonth $dayOfWeek $monthOfYear
else
    backup $1 $2 $3 $4
fi
