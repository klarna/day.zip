<center>
  <img src="logo.png" width="250" />
  <img src="https://cl.ly/2s0s0o0P0D1z/daily.gif" />
</center>



### Dependencies

PI: raspberrypi 4.4.11-v7+

OS: [Raspbian GNU/Linux 8.0 (jessie)](https://www.raspberrypi.org/downloads/raspbian/) (install [NOOB](https://www.raspberrypi.org/downloads/noobs/) before)

### Install

```
curl -L https://git.io/v6vmR | sudo bash
```

Or if you're suspicious of the simplicity of the script above:

```
cd ~
git clone git@github.com:klarna/day.zip.git
cd day.zip
sudo bash boot.sh
```

### Config

To customize your day.zip, simply update the `config.env` file.

### Resources

[Building ffmpeg + x264 on RaspberryPi](http://www.jeffreythompson.org/blog/2014/11/13/installing-ffmpeg-for-raspberry-pi/)

[Creating a slideshow with ffmpeg](https://trac.ffmpeg.org/wiki/Create%20a%20video%20slideshow%20from%20images)

[How to set up a scheduled task (Cron) with the Raspberry Pi](https://www.youtube.com/watch?v=UggNZundvPk)

[Slack API: File upload](https://api.slack.com/methods/files.upload/test)

[iPhone time lapse config](http://9to5mac.com/2014/10/01/iphone-time-lapse/)
