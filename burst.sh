#!/bin/bash

source config.env

function finish {
  rm -rf /home/pi/burst
  rm /home/pi/lockfile
  rm /home/pi/day.zip/burst.gif
  rm /home/pi/day.zip/burst.mp4
}
trap finish EXIT

day=`date +"%Y-%m-%d"`
dir="/home/pi/burst"
`mkdir ${dir}`

while [ -f "/home/pi/lockfile" ]; do
  sleep 1
done

`touch /home/pi/lockfile`

# Capturing images
echo "Capturing images"
`ffmpeg -t ${BURST_DURATION_SEC} -s 1280x960 -i /dev/video0 -r ${BURST_FRAME_RATE} -f image2 /home/pi/burst/image%04d.jpg`

# Creating GIF
echo "Creating GIF"
`ffmpeg -f image2 -framerate 5 -pattern_type glob -i '/home/pi/burst/*.jpg' burst.gif`

# Creating MP4
echo "Creating MP4"
`ffmpeg -framerate 15 -pattern_type glob -i '/home/pi/burst/*.jpg' -c:v libx264 -vf crop=960:960:160:0 burst.mp4`

quote=`shuf -n 1 quotes.txt`
# Uploading to Instagram
echo "Uploading to Instagram"
video_path=`/home/pi/day.zip/instagram/instagram -u ${INSTAGRAM_USER} -p ${INSTAGRAM_PASS} -f burst.mp4 -c ""`

# Uploading to Slack
echo "Uploading to Slack"
`slack="curl -F file=@burst.gif -F channels=da_pi_team -F title='Minute.zip' -F initial_comment='Like it in instagram: ${video_path}. ${quote}' -F token=${SLACK_TOKEN} https://slack.com/api/files.upload | grep -o '\"ok\":true'"`

exit 0
