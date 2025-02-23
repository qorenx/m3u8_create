Replace the source/main.mp4 file with the file you will convert. It should be mp4.
Then extract the ffmpeg.rar, ffplay.rar, ffprobe.rar files from the rar. I made it rar because the Github limit is 100mb.
Delete the files in the converter folder. Be sure to do this in every process.

If you run create_m3u8.cmd, you will use it with my settings. However, if you are going to make your own settings. open it with notepad.
:: General Settings
set input=source/main.mp4
set output=converter
:: crf: HD 0 < > 51 SD
set crf=28
:: h264 and libx265
set codec=h264
:: audio_bitrate: 64k 96k 128k etc
set audio_bitrate=96k
:: preset: ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow
set preset=ultrafast
:: hls_time: 10000second
set hls_time=10000
There is a section. You can make settings from here.

For a quality encode, you can make libx265 and slow crf 25. Size and duration increase. The choice is yours.