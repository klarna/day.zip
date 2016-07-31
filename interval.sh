#!/bin/sh

day=`date +"%Y-%m-%d"`
timestamp=`date +"%Y-%m-%d-%H-%M-%S"`
`mkdir /home/pi/${day}`
`touch /home/pi/"${day}/${timestamp}.txt"`
echo "INTERVAL!"
