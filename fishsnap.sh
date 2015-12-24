#!/bin/sh

# left-bottom
HSHIFT=422
LSHIFT=598

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

DISPLAY=:0.0 scrot  hoge.png 
convert -crop 800x600+${LSHIFT}+${HSHIFT} hoge.png ${SAVE}/${FILENAME}
DISPLAY=:0.0 display  ${SAVE}/${FILENAME}
