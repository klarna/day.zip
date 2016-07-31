#!/bin/sh

day=`date +"%Y-%m-%d"`
dir="/home/pi/burst"
`mkdir ${dir}`


while [ -f "/home/pi/lockfile" ]; do
  sleep 1
done

`touch /home/pi/lockfile`

counter=BURST_FRAME_RATE*BURST_DURATION_SEC

while counter > 0
do
  timestamp=`date +"%Y-%m-%d-%H-%M-%S-%N"`
  file="${dir}/${timestamp}.jpg"

  shot="fswebcam -r 1080x1080 --no-banner ${file}"
  echo "****** Running ${shot}"
  eval $shot

  # sleep 1/BURST_FRAME_RATE
  let counter-=1
done

`rm /home/pi/lockfile`
exit 0
