#!/bin/bash

VID=`ps auxw| awk '/raspivid/ && ! /awk/ {print $2}'`
if [ ! -z "$VID"  ]; then
  kill -9 $VID
fi 

if [ ! -n "$1" ]; then
  OPT="Photo"
  else OPT=$1
fi 

if [ `echo $0 | sed 's@[a-z/]*/@@g'` = 'tweet.sh' ]; then
  EXE=twitter
  PICT_W=506
  PICT_H=253
else 
  EXE=picture
  PICT_W=800
  PICT_H=600
fi
  
DIR=`date "+%Y/%m%d"`

SAVE=$HOME/photo/${DIR}

if [ ! -d $SAVE ]; then
  mkdir -p $SAVE
fi

if [ "$?" != "0" ]; then
  echo Cannot make dir.
  exit 1
fi

FILENAME=`date "+%H-%M-%S.png"`

raspistill \
  -t 1 \
  -e png  \
  -w $PICT_W -h $PICT_H \
  -o ${SAVE}/${FILENAME} 

echo ${SAVE}/${FILENAME}

echo $OPT
if [ $EXE = "twitter"  ]; then
  tw $OPT  --file=${SAVE}/${FILENAME} --yes
fi

raspivid -t 0 -h $PICT_H -w $PICT_W &

fbi -a -t 3 -1 -T 1 -d /dev/fb0  ${SAVE}/${FILENAME}
#display  ${SAVE}/${FILENAME}

