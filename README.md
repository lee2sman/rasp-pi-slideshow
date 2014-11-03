Raspberry Pi Slideshow
======================

A self-booting slideshow (also sometimes referred to as a digital picture frame), created on a raspberry pi, originally configured for the exhibition Hard To Please at Little Berlin art space, November 2014.

When configured properly your raspberry pi (when it's booted) will turn on and launch a looping slideshow, directly from the command line. 

No need to use or launch a GUI!

I've written this file to be somewhat beginner-friendly by telling you (barely) how to use Nano and explaining how to do some things that more advanced users will already know. Feel free to roll your eyes and skip over my explanations.

Items Needed
============
* Raspberry Pi computer (any model. case optional)
* SD Card (2gb or greater)
* hdmi cable (or vga converter. or s-video cable if plugging into a tv)
* monitor
* 5v usb power supply (can sometimes be found in thrift store) with micro usb cable (to power the pi)
* ethernet cable
* keyboard
* SD card reader
* thumb drive to move images from your computer to the pi

Overview of procedure
=====================
* Download and install raspbian operating system
* Copy over images to the pi's sd card
* Configure the pi
* Run it

Install Operating System
========================
1.  There are numerous ways to do this. Here's one. Download and unzip the Raspbian operating system from this page
http://www.raspberrypi.org/downloads/
2.  Plug your sd card into your computer (via a card reader)
3.  Open your terminal up.
4.  Figure out which disk is your sd card. (If on a mac you run diskutil)
`diskutil list`
MAKE SURE YOU FIGURE OUT WHICH ONE EXACTLY IS THE SD CARD AND NOTE WHICH DISK THIS IS (for example disk4, not disk4s1, definitely not disk0 and probably not disk1)
5.  Unmount the sd card
`unmount /dev/disk4 #remember to place disk4 with your proper disk number`
6.  copy the iso image of raspbian to your sd card
`sudo dd if=file_name_with_location_of_raspbian.img of=/dev/rdisk4 bs=1M`
7.  Wait a long time but not as long as if you hadn't typed r before disk4. Using raw formatting makes it much much faster.
8.  When the terminal prompt reappears it's done formatting to the sd card. Eject the sd card now.
9.  Build your pi. Plug in keyboard, monitor, ethernet cable to your router, then power and wait for it to start.

Configuring Raspberry Pi
========================
10.  When you plug in power the pi will boot up and run initialization. 
11.  The initial time you sign in, your name is pi and your password is raspberry.
12.  Configure your keyboard and expand your file system
`sudo raspi-config`
This launches a "curses" text window. Select "expand root partition to fill SD card" by moving down with your arrow keys and hitting enter.
Choose configure keyboard and navigate the various options so that you eventually select a US keyboard. I have a mac keyboard so I found that.
Afterwards, reboot by navigating to Finish and selecting it.
13.  Let's turn on Auto-Login so you don't have to type your name and pswd each time.
`sudo nano /etc/inittab`
Move down to the line that starts with 1:2345:respawn:/sbin/getty ... and put a # in front of it to comment that line out (This is why you needed to select a US keyboard. The UK one doesn't have that key)
Just below that line add the following.
`1:2345:respawn:/bin/login -f pi tty1 </dev/tty1 >/dev/tty1 2>&1`
Press Ctrl-X to exit. Type y to save the file and press enter to confirm filename.
14.  Time to move images over. If your images on your thumb drive, create a directory within the pi's home directory to copy them to.
`cd`
`mkdir slides`
`cd slides`
`cp *.jpg /dev/sda1 .`
15.  Let's turn off power saving, screen savers, etc.
`sudo nano /etc/kbd/config`
Look for the line containing "blank_time=" and set to 0. 
Look for the line containing "powerdown_time=" and set to 0.
`sudo nano /etc/lightdm/lightdm.conf`
Look for the [Seat Default] section of this file. Under that heading add the line:
`xserver-command=X -s 0 dpms`

Install Slideshow Software
==========================
16.  Update apt-get and install fbi. Apt-get is a package manager, similar to using an app store, but for the terminal. And no cost :)
`sudo apt-get update`
`sudo apt-get install fbi`
I think you also need imagemagick.
`sudo apt-get install imagemagick`
17.  Let's create a script to launch this program when the computer is booted.
`sudo nano /etc/profile`
Enter this line at the end of the file.
`. /home/pi/slideshow.sh`
Save and exit. Ctrl+X, followed by Y, and then by hitting enter.
18.  Now we'll create the slideshow.sh script that the profile references.
`cd /home/pi`
`sudo nano slideshow.sh`
Enter the following into this file.
`#!/bin/bash`
`sleep 15 #this is probably optonal`
`fbi -noverbose -a -t 5 /home/pi/slides/*.jpg`
Exit and save with Ctrl-X, Y, hit enter.
19.  Let's make the file executable
`sudo chmod +x /home/pi/slideshow.sh`
20.  Restart. It should now run.
`sudo shutdown -r now`
