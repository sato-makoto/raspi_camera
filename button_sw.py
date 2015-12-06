#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Check from GPIO 28 to 31
# when GPIO is False
# print messages of button 
# pressed

from time import sleep
import RPi.GPIO as GPIO
from subprocess import call
GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)

# prevent cattering?
wait = 0.01

def input_check(port):
  button = GPIO.input(port)
  sleep(wait)
  return (button, port)

esc = [31, 37, 33, 30]
seq_begin = '\033[1;'
seq_end = '\033[00m'

ports = [28, 29, 30, 31]
for port in ports:
  GPIO.setup(port, GPIO.IN)

while True:
  for port in ports:
    check = input_check(port)
    if check[0] == False:
      if port == ports[0]:
        print '{0}{1}m赤い釦{2}(VID開始)' . \
          format(seq_begin, esc[0], seq_end)
        call("sudo -u pi sh /home/pi/work/bin/800x600vid.sh", shell=True)
      elif port == ports[1]:
        print '{0}{1}m白い釦{2}(シャッター)' . \
          format(seq_begin, esc[1], seq_end)
        call("sudo -u pi sh /home/pi/work/bin/snap.sh", shell=True)
      elif port == ports[2]:
        print '{0}{1}m黄の釦{2}(VID停止)' . \
	  format(seq_begin, esc[2], seq_end)
        call("sudo -u pi sh /home/pi/work/bin/vid_stop.sh", shell=True)
      elif port == ports[3]:
        print '{0}{1}m灰の釦{2}シャットダウン' . \
	  format(seq_begin, esc[3], seq_end)
        call("shutdown -h now", shell=True)
      while check[0] == False:
        check = input_check(port)
