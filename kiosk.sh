#!/bin/bash

export DISPLAY=:0

unclutter &

sed -i 's/""exited_cleanly"":false/""exited_cleanly"":true/' /home/pi/.config/chromium/Default/Preferences
sed -i 's/""exit_type"":""Crashed""/""exit_type"":""Normal""/' /home/pi/.config/chromium/Default/Preferences

/usr/bin/chromium-browser --window-size=1920,1080 --kiosk --window-position=0,0 http://1.220.196.5/pop/POP130 &

