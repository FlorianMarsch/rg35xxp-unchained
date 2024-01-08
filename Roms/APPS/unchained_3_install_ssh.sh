#!/bin/sh
echo $0 $*
progdir=`dirname "$0"`
log=$progdir/UNCHAINED/install-ssh-log.txt

touch $log

#Make sure this script is running as root.
whoami > $log 2>&1 


apt-get install -y openssh-server >> $log 2>&1
systemctl enable ssh --now >> $log 2>&1
systemctl status ssh >> $log 2>&1

cp $progdir/etc/ssh/sshd_config /etc/ssh/sshd_config 

addgroup --system sshusers >> $log 2>&1
adduser root sshusers >> $log 2>&1

service ssh restart >> $log 2>&1