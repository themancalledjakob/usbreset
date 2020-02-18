```
studio       _       _
 _ __   ___ (_)_ __ | |_ ___ _ ____/\__
| '_ \ / _ \| | '_ \| __/ _ \ '__\    /
| |_) | (_) | | | | | ||  __/ |  /_  _\
| .__/ \___/|_|_| |_|\__\___|_|    \/
|_|
      presents: usbreset

      studio@pointer.click
```

# what is this for?
Sometimes realsense camera's have to be unplugged
and replugged. Often a reboot doesn't help.
Maybe we're not even physically close to the machine and it's not possible to unplug and replug them manually.
In these cases, we can run this script.

It is tested on Ubuntu 16.04 and 18.04

# how to
- `./build.sh`
- `sudo ./resetall.sh`

# run sudo without password (unattended)
- `sudo visudo`
- add a line at the bottom
- `<username> ALL = NOPASSWD: /path/to/resetall.sh, /path/to/detachSerial.sh`
- save and close the editor (vim `:wq` or nano `ctrl+o` then `ctrl+x`

# other options first
you can also hardware reset the devices with realsense sdk:
https://github.com/IntelRealSense/librealsense/issues/2161#issuecomment-408779150
rather do that if it works for you

# could this be used also for other usb cameras?
i believe it can be used for any usb device. didn't try though. You would have to adjust the hardcoded 'RealSense' references.

# could I accidentially disable all usb ports and not have access via mouse and/or keyboard to the machine?
yes absolutely. Usually this is solved with a reboot though.
In any case **judge for yourself**, read the scripts and look up what the commands do. They're running with admin privileges so you should know what they're doing.

# disclaimer
USE ON YOUR OWN RISK. THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER OR CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
