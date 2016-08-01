# done
echo "*** *** *** *** *** *** ***"
echo "Installing day.zip, please be patient."
echo "*** *** *** *** *** *** ***"

# crontab
crontab crontab-file

# x264
cd ~
git clone git://git.videolan.org/x264
cd x264
./configure --host=arm-unknown-linux-gnueabi --enable-static --disable-opencl
make
sudo make install

# ffmpeg
cd ~
git clone https://github.com/FFmpeg/FFmpeg.git
cd ffmpeg
sudo ./configure --arch=armel --target-os=linux --enable-gpl --enable-libx264 --enable-nonfree
make
sudo make install

# run it
python button_pro.py

# done
echo "*** *** *** *** *** *** ***"
echo "Install finished. Enjoy your day.zip!"
echo "*** *** *** *** *** *** ***"
