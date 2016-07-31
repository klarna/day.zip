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
  echo "Locked ..."
done
touch /home/pi/lockfile

# ffmpeg="ffmpeg -f image2 -framerate 5 -pattern_type glob -i '${dir}/*.jpg' -vf scale=500x500 out.gif"
# slack="curl -F file=@out.gif -F channels=da_pi_team -F token=${SLACK_TOKEN} https://slack.com/api/files.upload | grep -o '\"ok\":true'"

#echo "****** Running ffmpeg command: ${ffmpeg}"
rm daily.gif
rm daily.mp4

files="${dir}/*.jpg"

echo "************"
echo "Creating GIF"
echo "************"
# Creating GIF
`ffmpeg -f image2 -framerate 30 -pattern_type glob -i '$files' daily.gif`

echo "************"
echo "Creating MP4"
echo "************"
# Creating MP4
`ffmpeg -framerate 30 -pattern_type glob -i '$files' -c:v libx264 -vf crop=960:960:160:0 daily.mp4`

quote=`shuf -n 1 quotes.txt`
echo "************"
echo "Quote ${quote}"
echo "************"

# Uploading to Instagram
echo "************"
echo "Uploading to Instagram"
echo "************"
video_path=`/home/pi/day.zip/instagram/instagram -u ${INSTAGRAM_USER} -p ${INSTAGRAM_PASS} -f daily.mp4 -c "${quote} #insideklarna"`

# Uploading to Slack
echo "************"
echo "Uploading to Slack"
echo "************"
`slack="curl -F file=@burst.gif -F channels=da_pi_team -F title='Day.zip' -F initial_comment='Like it in instagram: ${video_path}. ${quote}' -F token=${SLACK_TOKEN} https://slack.com/api/files.upload | grep -o '\"ok\":true'"`

exit 0
