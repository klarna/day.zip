#!/bin/bash

function finish {
  rm /home/pi/lockfile
}
trap finish EXIT

day=`date +"%Y-%m-%d"`
timestamp=`date +"%Y-%m-%d-%H-%M-%S"`
dir="/home/pi/daily/${day}"
`mkdir ${dir}`
file="${dir}/${timestamp}.jpg"

while [ -f "/home/pi/lockfile" ]; do
  echo "Locked..."
  sleep 1
done

touch /home/pi/lockfile

shot="fswebcam -r 1080x1080 --no-banner ${file}"
echo "****** Running ${shot}"
eval $shot

if [ -f "$file" ]; then
    echo "Pic taken successfully"
    exit 0
else
    echo "Pic failed"
    exit 1
fi

