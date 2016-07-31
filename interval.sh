#!/bin/sh

day=`date +"%Y-%m-%d"`
timestamp=`date +"%Y-%m-%d-%H-%M-%S"`
dir="/home/pi/${day}"
`mkdir ${dir}`
file="${dir}/${timestamp}.jpg"

shot="fswebcam -r 1080x1080 --no-banner ${file}"
echo "****** Running ${shot}"
eval $shot

if [ -f "$file" ]; then
    echo "Pic taken successfully"
    exit 0
else
    echo "slack upload failed, retrying..."
    sleep 5
    eval $shot

    if [ -f "$file" ]; then
        echo "Pic taken successfully in 2nd attempt"
        exit 0
    else
        echo "yeap, doesnt work"
        exit 1
    fi
    exit 1
fi

