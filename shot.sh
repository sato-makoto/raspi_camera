#!/bin/bash
# still snap

EXE=picture
PICT_W=800
PICT_H=600
  
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


LANG=C sudo fbi -a -t 10 -1 -T 1 -d /dev/fb0  ${SAVE}/${FILENAME}
#display  ${SAVE}/${FILENAME}

