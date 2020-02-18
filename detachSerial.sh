#!/bin/bash
#
# studio       _       _
#  _ __   ___ (_)_ __ | |_ ___ _ ____/\__
# | '_ \ / _ \| | '_ \| __/ _ \ '__\    /
# | |_) | (_) | | | | | ||  __/ |  /_  _\
# | .__/ \___/|_|_| |_|\__\___|_|    \/
# |_|
#       presents: detachserial.sh
#
# -------------
# detach a serial
# 
# handy if a faulty device breaks things
# and you need to remotely "unplug" it
#
# studio@pointer.click
#
##################################################################

# echo found realsense cameras
for f in /dev/bus/usb/*; do
    bus=$(basename $f)
    for p in ${f}/*; do
        port=$(basename $p)
        udevadm info --query=all --attribute-walk --name=$p | grep 'RealSense' &> /dev/null
        if [ $? == 0 ]; then
            serial=$(udevadm info --query=all --attribute-walk --name=$p | grep ATTR\{serial\})
            echo " ::::: > found camera at bus: $bus port: $port serial: $serial"
        fi
    done
done

# we need a serial number to detach it.. if none is given we quit
if [ $# -eq 0 ]; then
    echo "No serial number provided, I'm out!"
    echo "use me like: $0 <serial_number>"
    echo "e.g.: $0 825513025043"
    exit 1
fi

serialkill=$1

# actually detach serial port
for f in /dev/bus/usb/*; do
    bus=$(basename $f)
    for p in ${f}/*; do
        port=$(basename $p)
        udevadm info --query=all --attribute-walk --name=$p | grep 'RealSense' &> /dev/null
        if [ $? == 0 ]; then
            serial=$(udevadm info --query=all --attribute-walk --name=$p | grep ATTR\{serial\})
            if [ -z "${serial##*$serialkill*}" ]
                then
                    echo "killing $bus $port $serial"
                    usb_modeswitch -v 0x8086 -p 0x0ad3 -b $bus -g $port -d
            fi
        fi
    done
done

