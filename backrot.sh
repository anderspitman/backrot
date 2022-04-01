#!/bin/bash

set -e

function backup {

    inPath=$1
    destDir=$2
    dayOfYear=$3
    dayOfMonth=$4
    dayOfWeek=$5
    monthOfYear=$6

    mkdir -p $destDir/daily $destDir/weekly $destDir/monthly $destDir/yearly

    if (( $dayOfYear == 1 )); then
        timestamp=$(date --iso-8601=seconds)
        mv $inPath $destDir/yearly/$timestamp.dump 
    elif (( $dayOfMonth == 1 )); then
        mv $inPath $destDir/monthly/$monthOfYear.dump 
    elif (( $dayOfMonth == 8 )); then
        mv $inPath $destDir/weekly/1.dump 
    elif (( $dayOfMonth == 15 )); then
        mv $inPath $destDir/weekly/2.dump 
    elif (( $dayOfMonth == 22 )); then
        mv $inPath $destDir/weekly/3.dump 
    else
        mv $inPath $destDir/daily/$dayOfWeek.dump
    fi
}

function usage {
    echo "Usage: backrot.sh IN_PATH OUT_DIR"
}

inPath=$1
if [[ -z $inPath ]]; then
    usage
    exit 1
fi

destDir=$2
if [[ -z $destDir ]]; then
    usage
    exit 1
fi

if [[ -z $3 ]]; then
    dayOfYear=$(date +%-j)
    dayOfMonth=$(date +%-d)
    dayOfWeek=$(date +%-u)
    monthOfYear=$(date +%-m)

    backup $inPath $destDir $dayOfYear $dayOfMonth $dayOfWeek $monthOfYear
else
    backup $1 $2 $3 $4
fi
