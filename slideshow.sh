#!/bin/bash
# slideshow script for raspberry pi
# this file is for autolaunching your slideshow program fbi at startup
#
INTERVAL=5 #how many seconds for each slide
fbi -noverbose -a -t $INTERVAL /home/pi/slides/*.jpg

# here's almost exactly the same, but with photos appearing in random order
# comment the above fbi line and uncomment this one to use it
# fbi -noverbose -a -t $INTERVAL -u /home/pi/slides/*.jpg
#
# NEW alternate method using feh (thanks TechnologyClassroom for suggestion)
# feh -FZYD 5 --cycle-once /home/pi/slides/*.png

