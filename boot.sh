#!/bin/bash

echo "*** *** *** *** *** *** ***"
echo "Installing day.zip, please be patient."
echo "*** *** *** *** *** *** ***"
sudo aptitude update

echo "*** *** *** *** *** *** ***"
echo "Installing fswebcam"
echo "*** *** *** *** *** *** ***"
sudo apt-get -y install fswebcam

echo "*** *** *** *** *** *** ***"
echo "Installing php. Yucc."
echo "*** *** *** *** *** *** ***"
sudo apt-get -y install php5
sudo apt-get -y install php5-gd
sudo apt-get -y install php5-curl

echo "*** *** *** *** *** *** ***"
echo "Setting up crontab"
echo "*** *** *** *** *** *** ***"
crontab crontab-file

echo "*** *** *** *** *** *** ***"
echo "Installing x264. Might take some time..."
echo "*** *** *** *** *** *** ***"
cd ~
git clone git://git.videolan.org/x264
cd x264
./configure --host=arm-unknown-linux-gnueabi --enable-static --disable-opencl
make
sudo make install

echo "*** *** *** *** *** *** ***"
echo "Installing ffmpeg. Might take some time..."
echo "*** *** *** *** *** *** ***"
cd ~
git clone https://github.com/FFmpeg/FFmpeg.git
cd ffmpeg
sudo ./configure --arch=armel --target-os=linux --enable-gpl --enable-libx264 --enable-nonfree
make
sudo make install

echo "*** *** *** *** *** *** ***"
echo "Running day.zip"
echo "*** *** *** *** *** *** ***"
python button_pro.py &

echo "*** *** *** *** *** *** ***"
echo "Install finished. Enjoy your day.zip!"
echo "*** *** *** *** *** *** ***"
