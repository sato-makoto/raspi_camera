#!/bin/sh
# http://wiki.oz9aec.net/index.php/Raspberry_Pi_Camera

if [ -z "$1" ]; then
  echo No remote host.
  exit 1
fi

raspivid -n -w 800 -h 600 -rot 180 -b 4500000 -fps 30 -vf -hf -t 0 -o - | \
     gst-launch-1.0 -v fdsrc \
     !  h264parse \
     ! rtph264pay config-interval=10 pt=96  \
     ! udpsink \
     host=$1 port=9000
