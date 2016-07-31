#!/bin/bash

source config.env
day=`date +"%Y-%m-%d"`
dir="/home/pi/daily/${day}"

function finish {
  # Don't do this for now, else it will delete all our pics from today!
  # `rm -rf ${dir}`
  rm /home/pi/day.zip/daily.gif
  rm /home/pi/day.zip/daily.mp4
}
trap finish EXIT

rm daily.gif
rm daily.mp4

files="${dir}/*.jpg"

echo "************"
echo "Creating MP4"
echo "************"
# Creating MP4
ffmpeg -framerate 30 -pattern_type glob -i "$files" -c:v libx264 -vf crop=960:960:160:0 daily.mp4

quote=`shuf -n 1 quotes.txt`
echo "************"
echo "Quote ${quote}"
echo "************"

# Uploading to Instagram
echo "************"
echo "Uploading to Instagram"
echo "************"
video_path=`/home/pi/day.zip/instagram/instagram -u ${INSTAGRAM_USER} -p ${INSTAGRAM_PASS} -f daily.mp4 -c "${INSTAGRAM_DAILY_CAPTION}"`

echo "************"
echo "Creating GIF"
echo "************"
# Creating GIF
ffmpeg -f image2 -framerate 30 -pattern_type glob -i "$files" -vf scale=320:240 daily.gif -c "#insideklarna #daily"

# Uploading to Slack
echo "************"
echo "Uploading to Slack"
echo "************"
curl -F file=@daily.gif -F channels=tel-aviv,da_pi_team -F title='day.zip' -F initial_comment="${quote} \nLike it in Instagram: ${video_path}" -F token=${SLACK_TOKEN} https://slack.com/api/files.upload

exit 0
