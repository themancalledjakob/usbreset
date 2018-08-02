#!/bin/bash
pass='pp'
if [ $# -eq 1 ]
  then
    pass=$1
fi
ls /dev/bus/usb
for f in /dev/bus/usb/*; do
    bus=$(basename $f)
    for p in ${f}/*; do
        port=$(basename $p)
        udevadm info --query=all --attribute-walk --name=$p | grep 'RealSense' &> /dev/null
        if [ $? == 0 ]; then
            echo $pass | sudo -S ./usbreset $p
        fi
    done
done
for f in /dev/bus/usb/*; do
    bus=$(basename $f)
    for p in ${f}/*; do
        port=$(basename $p)
        udevadm info --query=all --attribute-walk --name=$p | grep 'RealSense' &> /dev/null
        if [ $? == 0 ]; then
            echo $pass | sudo -S usb_modeswitch -v 0x8086 -p 0x0ad3 -b $bus -g $port -R
        fi
    done
done
for f in /dev/bus/usb/*; do
    bus=$(basename $f)
    for p in ${f}/*; do
        port=$(basename $p)
        udevadm info --query=all --attribute-walk --name=$p | grep 'RealSense' &> /dev/null
        if [ $? == 0 ]; then
            echo $pass | sudo -S usb_modeswitch -v 0x8086 -p 0x0ad3 -b $bus -g $port -d
        fi
    done
done
sudo rmmod uvcvideo
sudo modprobe uvcvideo
