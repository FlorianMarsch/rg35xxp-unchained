#!/bin/sh
echo $0 $*
progdir=`dirname "$0"`
log=$progdir/UNCHAINED/wifi_log.txt

#Connect to your home wifi - day one stock image could only accept 36 chars in ui
ssid=WLAN-747965
password=85839213658870718207

touch $log
nmcli d wifi connect $ssid password $password > $log 2>&1


