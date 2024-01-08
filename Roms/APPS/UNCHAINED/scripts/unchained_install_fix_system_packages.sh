#!/bin/sh
echo $0 $*
progdir=`dirname "$0"`

whoami

aptitude remove sudo
aptitude install sudo

chown -R root:root /usr