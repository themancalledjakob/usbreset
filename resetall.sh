#!/bin/bash
#
# studio       _       _
#  _ __   ___ (_)_ __ | |_ ___ _ ____/\__
# | '_ \ / _ \| | '_ \| __/ _ \ '__\    /
# | |_) | (_) | | | | | ||  __/ |  /_  _\
# | .__/ \___/|_|_| |_|\__\___|_|    \/
# |_|
#       presents: resetall.sh
#
# -------------
# sometimes realsense camera's have to be unplugged
# and replugged. Often a reboot doesn't help.
# In these cases, we can run this script.
#
# Don't forget to run with sudo
# if you need to run it unattended read the README.md
#
# studio@pointer.click
#
##################################################################
ls /dev/bus/usb
for f in /dev/bus/usb/*; do
    bus=$(basename $f)
    for p in ${f}/*; do
        port=$(basename $p)
        udevadm info --query=all --attribute-walk --name=$p | grep 'RealSense' &> /dev/null
        if [ $? == 0 ]; then
            echo " ::::: > found camera at bus: $bus port: $port"
        fi
    done
done
for f in /dev/bus/usb/*; do
    bus=$(basename $f)
    for p in ${f}/*; do
        port=$(basename $p)
        udevadm info --query=all --attribute-walk --name=$p | grep 'RealSense' &> /dev/null
        if [ $? == 0 ]; then
            ./usbreset $p
            echo " ::::: > reset $bus $port with cpp ioctl"
        fi
    done
done
for f in /dev/bus/usb/*; do
    bus=$(basename $f)
    for p in ${f}/*; do
        port=$(basename $p)
        udevadm info --query=all --attribute-walk --name=$p | grep 'RealSense' &> /dev/null
        if [ $? == 0 ]; then
            usb_modeswitch -v 0x8086 -p 0x0ad3 -b $bus -g $port -R
            echo " ::::: > reset $bus $port with usb_modeswitch"
        fi
    done
done
for f in /dev/bus/usb/*; do
    bus=$(basename $f)
    for p in ${f}/*; do
        port=$(basename $p)
        udevadm info --query=all --attribute-walk --name=$p | grep 'RealSense' &> /dev/null
        if [ $? == 0 ]; then
            usb_modeswitch -v 0x8086 -p 0x0ad3 -b $bus -g $port -d
            echo " ::::: > detach $bus $port with usb_modeswitch"
        fi
    done
done
echo " ::::: > unload driver"
rmmod uvcvideo
sleep 1
echo " ::::: > reload driver"
modprobe uvcvideo
#echo " ::::: > temporarily unloading faulty camera"
#./detachSerial.sh <serial>
