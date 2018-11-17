#!/bin/bash
for f in /dev/bus/usb/*; do
    bus=$(basename $f)
    for p in ${f}/*; do
        port=$(basename $p)
        udevadm info --query=all --attribute-walk --name=$p | grep 'RealSense' &> /dev/null
        if [ $? == 0 ]; then
            RsSERIAL=$(udevadm info --query=all --attribute-walk --name=$p | grep -oP 'ATTR{serial}=="\K[^"]+')
            echo " ::::: > found camera at bus: $bus port: $port serial: $RsSERIAL"
        fi
    done
done
