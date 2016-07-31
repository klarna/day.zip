#!/bin/bash

source /home/pi/day.zip/config.env

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
  echo 'Locked...'
  sleep 1
done

touch /home/pi/lockfile

# Capturing images
ffmpeg -t ${BURST_INPUT_DURATION_SEC} -s ${BURST_INPUT_RESOLUTION} -i /dev/video0 -r ${BURST_INPUT_FRAME_RATE} -f image2 /home/pi/burst/image%04d.jpg

# Creating GIF
ffmpeg -f image2 -framerate ${BURST_OUTPUT_FRAME_RATE} -pattern_type glob -i '/home/pi/burst/*.jpg' -vf scale=${BURST_GIF_RESOLUTION} /home/pi/day.zip/burst.gif
# Creating MP4
ffmpeg -framerate ${BURST_OUTPUT_FRAME_RATE} -pattern_type glob -i '/home/pi/burst/*.jpg' -c:v libx264 -vf crop=960:960:160:0 /home/pi/day.zip/burst.mp4

# Uploading to Instagram
video_path=`/home/pi/day.zip/instagram/instagram -u ${INSTAGRAM_USER} -p ${INSTAGRAM_PASS} -c "${INSTAGRAM_BURST_CAPTION}" -f /home/pi/day.zip/burst.mp4`

# Uploading to Slack
curl -F file=@/home/pi/day.zip/burst.gif -F channels=da_pi_team -F title='minute.zip' -F initial_comment="Like it in Instagram: ${video_path}" -F token=${SLACK_TOKEN} https://slack.com/api/files.upload

exit 0
