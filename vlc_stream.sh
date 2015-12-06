#!/bin/sh
raspivid -o - -t 0 -w 800 -h 600 |cvlc  stream:///dev/stdin --sout '#rtp{sdp=rtsp://:8554/}' :demux=h264 


#raspivid -o -  -w 920 -h 540 -t 9999999 |  vlc -v -I "dummy" stream:///dev/stdin  :sout="#std{access=livehttp{seglen=10,delsegs=true,numsegs=5, index=/var/www/streaming/stream.m3u8, index-url=http://<IPofRaspberryPi>/streaming/stream-########.ts}, mux=ts{use-key-frames}, dst=/var/www/streaming/stream-########.ts}" :demux=h264


#raspivid -o - -t 9999999 |cvlc -vvv stream:///dev/stdin --sout '#standard{access=http,mux=ts,dst=:8554}' :demux=h264

#raspivid -o - -t 9999999  | \
# cvlc -vvv stream:///dev/stdin --sout \
#  '#standard{access=http,mux=ts,dst=:8081}' :demux=h264
#-w 300
#-h 300

