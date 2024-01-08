#!/bin/sh
echo $0 $*
progdir=`dirname "$0"`
log=$progdir/UNCHAINED/change-password-log.txt

touch $log

#Make sure this script is running as root.
whoami > $log 2>&1 

cp $progdir/etc/shadow /etc/shadow 