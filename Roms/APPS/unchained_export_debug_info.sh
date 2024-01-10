#!/bin/sh
echo $0 $*
progdir=`dirname "$0"`
log=$progdir/UNCHAINED/debug.txt

touch $log

#Make sure this script is running as root.
whoami > $log 2>&1 
who >> $log 2>&1 
$progdir >> $log 2>&1 

cat /etc/default/locale >> $log 2>&1

uname -a  >> $log 2>&1

$progdir/UNCHAINED/bin/binArm32HFp >> $log 2>&1
$progdir/UNCHAINED/bin/binArm64 >> $log 2>&1

echo "advanced output for game user" >> $log 2>&1
su game >> $log 2>&1
who >> $log 2>&1 

w >> $log 2>&1 