#!/bin/bash

day=`date +"%Y-%m-%d"`
dir="/home/pi/daily/${day}"
files="${dir}/*.jpg"

echo "************"
echo "Creating GIF"
echo "************"
# Creating GIF
`ffmpeg -f image2 -framerate 30 -pattern_type glob -i '/home/pi/daily/2016-07-31/*.jpg' daily.gif`
