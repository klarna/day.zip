#!/bin/sh

day=`date +"%Y-%m-%d"`
timestamp=`date +"%Y-%m-%d-%H-%M-%S"`
dir="/home/pi/${day}"
`mkdir ${dir}`

# `touch /home/pi/"${day}/${timestamp}.txt"`

shot="fswebcam -r 1080x1080 --no-banner ${dir}/${timestamp}.jpg"

if eval $shot ; then
    echo "Pic taken successfully"
    exit 0
else
    echo "slack upload failed"
    exit 1
fi

