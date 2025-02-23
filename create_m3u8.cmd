@echo off
setlocal enabledelayedexpansion

:: Genel Ayarlar
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

if not exist %output% (
    mkdir %output%
)

:: 1080p
ffmpeg -y -loglevel verbose -i %input% -vf scale=-2:1080 -c:a libopus -b:a %audio_bitrate% -c:v %codec% -crf %crf% -preset %preset% -tag:v hvc1 -hls_time %hls_time% -hls_playlist_type vod -hls_segment_filename %output%\index-f1-v1-a%%d.ts %output%\index-f1-v1-a1.m3u8

:: 720p
ffmpeg -y -loglevel verbose -i %input% -vf scale=-2:720 -c:a libopus -b:a %audio_bitrate% -c:v %codec% -crf %crf% -preset %preset% -tag:v hvc1 -hls_time %hls_time% -hls_playlist_type vod -hls_segment_filename %output%\index-f2-v1-a%%d.ts %output%\index-f2-v1-a1.m3u8

:: 480p
ffmpeg -y -loglevel verbose -i %input% -vf scale=-2:480 -c:a libopus -b:a %audio_bitrate% -c:v %codec% -crf %crf% -preset %preset% -tag:v hvc1 -hls_time %hls_time% -hls_playlist_type vod -hls_segment_filename %output%\index-f3-v1-a%%d.ts %output%\index-f3-v1-a1.m3u8

:: 360p
ffmpeg -y -loglevel verbose -i %input% -vf scale=-2:360 -c:a libopus -b:a %audio_bitrate% -c:v %codec% -crf %crf% -preset %preset% -tag:v hvc1 -hls_time %hls_time% -hls_playlist_type vod -hls_segment_filename %output%\index-f4-v1-a%%d.ts %output%\index-f4-v1-a1.m3u8

:: Master playlist
echo #EXTM3U > %output%\master.m3u8
echo #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1606790,RESOLUTION=1920x1080,FRAME-RATE=25.000,CODECS="hvc1.1.6.L93.B0,mp4a.40.2" >> %output%\master.m3u8
echo index-f1-v1-a1.m3u8 >> %output%\master.m3u8
echo #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=923113,RESOLUTION=1280x720,FRAME-RATE=25.000,CODECS="hvc1.1.6.L93.B0,mp4a.40.2" >> %output%\master.m3u8
echo index-f2-v1-a1.m3u8 >> %output%\master.m3u8
echo #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=476714,RESOLUTION=854x480,FRAME-RATE=25.000,CODECS="hvc1.1.6.L93.B0,mp4a.40.2" >> %output%\master.m3u8
echo index-f3-v1-a1.m3u8 >> %output%\master.m3u8
echo #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=26218,RESOLUTION=640x360,FRAME-RATE=25.000,CODECS="hvc1.1.6.L93.B0,mp4a.40.2" >> %output%\master.m3u8
echo index-f4-v1-a1.m3u8 >> %output%\master.m3u8

:: I-Frame Streams
echo #EXT-X-I-FRAME-STREAM-INF:BANDWIDTH=1606790,RESOLUTION=1920x1080,CODECS="hvc1.1.6.L93.B0",URI="index-f1-v1-a1.m3u8" >> %output%\master.m3u8
echo #EXT-X-I-FRAME-STREAM-INF:BANDWIDTH=923113,RESOLUTION=1280x720,CODECS="hvc1.1.6.L93.B0",URI="index-f2-v1-a1.m3u8" >> %output%\master.m3u8
echo #EXT-X-I-FRAME-STREAM-INF:BANDWIDTH=476714,RESOLUTION=854x480,CODECS="hvc1.1.6.L93.B0",URI="index-f3-v1-a1.m3u8" >> %output%\master.m3u8
echo #EXT-X-I-FRAME-STREAM-INF:BANDWIDTH=26218,RESOLUTION=640x360,CODECS="hvc1.1.6.L93.B0",URI="index-f4-v1-a1.m3u8" >> %output%\master.m3u8

pause