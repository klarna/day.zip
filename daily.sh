#!/bin/bash

source config.env
day=`date +"%Y-%m-%d"`
dir="/home/pi/daily/${day}"

function finish {
  # `rm -rf ${dir}`
  rm /home/pi/lockfile
  rm /home/pi/day.zip/daily.gif
  rm /home/pi/day.zip/daily.mp4
}
trap finish EXIT

while [ -f "/home/pi/lockfile" ]; do
  sleep 1
done
touch /home/pi/lockfile

ffmpeg="ffmpeg -f image2 -framerate 5 -pattern_type glob -i '${dir}/*.jpg' -vf scale=500x500 out.gif"
slack="curl -F file=@out.gif -F channels=da_pi_team -F token=${SLACK_TOKEN} https://slack.com/api/files.upload | grep -o '\"ok\":true'"

echo "****** Running ffmpeg command: ${ffmpeg}"
rm out.gif

if eval $ffmpeg ; then
    echo "Gif created successfully"

    echo "****** Running slack upload: ${slack}"
    if eval $slack ; then
        echo "Uploaded to slack successfully"
        # `rm -rf ${dir}`
        exit 0
    else
        echo "slack upload failed"
        exit 1
    fi
else
    echo "ffmpeg failed"
    exit 1
fi
