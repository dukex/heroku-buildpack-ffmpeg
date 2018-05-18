Heroku buildpack: FFMpeg
=======================

This is a [Heroku buildpack](http://devcenter.heroku.com/articles/buildpacks) for using [ffmpeg](http://www.ffmpeg.org/) in your project.  
It doesn't do anything else, so to actually compile your app you should use [heroku-buildpack-multi](https://github.com/ddollar/heroku-buildpack-multi) to combine it with a real buildpack.

## ffmpeg static

ffmpeg version 4.0 Copyright (c) 2000-2018 the FFmpeg developers
  built with gcc 7 (Ubuntu 7.3.0-16ubuntu3)
  configuration: --prefix=/ffmpeg-static/target --pkg-config-flags=--static --pkg-config-flags=--static --extra-cflags='-I/ffmpeg-static/target/include -static' --extra-ldflags='-L/ffmpeg-static/target/lib -static' --extra-libs='-lpthread -lm -lz' --disable-shared --enable-static --extra-ldexeflags=-Bstatic --bindir=/ffmpeg-static/bin --enable-pic --enable-ffplay --enable-fontconfig --enable-frei0r --enable-gpl --enable-version3 --enable-libass --enable-libfribidi --enable-libfreetype --enable-libmp3lame --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libopus --enable-libsoxr --enable-libspeex --enable-libtheora --enable-libvo-amrwbenc --enable-libvorbis --enable-libxvid --enable-nonfree --enable-openssl
  libavutil      56. 14.100 / 56. 14.100
  libavcodec     58. 18.100 / 58. 18.100
  libavformat    58. 12.100 / 58. 12.100
  libavdevice    58.  3.100 / 58.  3.100
  libavfilter     7. 16.100 /  7. 16.100
  libswscale      5.  1.100 /  5.  1.100
  libswresample   3.  1.100 /  3.  1.100
  libpostproc    55.  1.100 / 55.  1.100
Hyper fast Audio and Video encoder
