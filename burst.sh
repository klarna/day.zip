#!/bin/bash

day=`date +"%Y-%m-%d"`
dir="/home/pi/burst"
`mkdir ${dir}`


while [ -f "/home/pi/lockfile" ]; do
  sleep 1
done

`touch /home/pi/lockfile`
`ffmpeg -t ${BURST_DURATION_SEC} -f v4l2 -framerate ${BURST_FRAME_RATE} -video_size 640x640 -i /dev/video0 burst.mkv`
`rm /home/pi/lockfile`
exit 0
