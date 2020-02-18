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
In these cases, we can run this script.

It is tested on Ubuntu 16.04 and 18.04

# any tips?
Don't forget to run with sudo
if you need to run it unattended, do this:
- `sudo visudo`
- add a line at the bottom
- `<username> ALL = NOPASSWD: /path/to/resetall.sh, /path/to/detachSerial.sh`
- save and close the editor (vim `:wq` or nano `ctrl+o` then `ctrl+x`

# anything else?
you can also hardware reset the devices with realsense sdk:
https://github.com/IntelRealSense/librealsense/issues/2161#issuecomment-408779150

However, using these scripts I found more reliable.
Maybe it's overkill, maybe only one method is enough, maybe it could be more elegant.. post an issue or send me an email if you have suggestions.

# more?
sure. before you can use this, you need to compile usbreset.c
Instructions are in the file!.

Good luck!
