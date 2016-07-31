#!/bin/bash

day=`date +"%Y-%m-%d"`
dir="/home/pi/burst"
`mkdir ${dir}`


while [ -f "/home/pi/lockfile" ]; do
  sleep 1
done

`touch /home/pi/lockfile`
`ffmpeg -t ${BURST_DURATION_SEC} -s 640x480 -i /dev/video0 -r ${BURST_FRAME_RATE} -f image2 ${dir}/image%04d.jpg`
`rm /home/pi/lockfile`

`ffmpeg -f image2 -framerate 5 -pattern_type glob -i '${dir}/*.jpg' -vf scale=500x500 out.gif`
`ffmpeg -framerate 5 -pattern_type glob -i '${dir}/*.jpg' -c:v libx264 out.mp4`

exit 0
