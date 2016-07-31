<center>
  <img src="logo.png" width="250" />
</center>


### Update crontab

Pull the changes and run the following in the pi:

```
sudo cp crontab-file /var/spool/cron/crontabs/pi 
```

Check if cron is running properly:

```
grep CRON /var/log/syslog
```

### Capture an image
```
fswebcam -r 1080x1080 --no-banner out.jpg
```

### Resources

[Building ffmpeg + x264 on RaspberryPi](http://www.jeffreythompson.org/blog/2014/11/13/installing-ffmpeg-for-raspberry-pi/)

[Creating a slideshow with ffmpeg](https://trac.ffmpeg.org/wiki/Create%20a%20video%20slideshow%20from%20images)

[How to set up a scheduled task (Cron) with the Raspberry Pi](https://www.youtube.com/watch?v=UggNZundvPk)

[Slack API: File upload](https://api.slack.com/methods/files.upload/test)

[iPhone time lapse config](http://9to5mac.com/2014/10/01/iphone-time-lapse/)