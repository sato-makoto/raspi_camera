#!/usr/bin/bash
MUSICPATH=/home/pi/Music/The_Beatles
WORKPATH=/home/pi/work/bin
SFILE=${WORKPATH}/p.txt
PLIST=${MUSICPATH}/playlist.txt

for t in `seq 3`
do 
  python3 ${WORKPATH}/rand83.py > $SFILE
  for x in `cat $SFILE`
  do
    mpv --no-terminal ${MUSICPATH}/$(sed -n ${x}p $PLIST)
    sleep 1
  done
  cd -
done

poweroff
