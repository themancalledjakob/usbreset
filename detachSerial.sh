#!/bin/bash
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

if [ $# -eq 0 ]; then
    exit 1
fi

serialkill=$1
pass='pp'

if [ $# -eq 2 ]; then
    pass=$2
fi

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
                    echo $pass | sudo -S usb_modeswitch -v 0x8086 -p 0x0ad3 -b $bus -g $port -d
            fi
        fi
    done
done

