#!/bin/bash
ls /dev/bus/usb
for f in /dev/bus/usb/*; do
    bus=$(basename $f)
    for p in ${f}/*; do
        port=$(basename $p)
        udevadm info --query=all --attribute-walk --name=$p | grep 'RealSense' &> /dev/null
        if [ $? == 0 ]; then
            echo pp | sudo -S ./usbreset $p
        fi
    done
done
