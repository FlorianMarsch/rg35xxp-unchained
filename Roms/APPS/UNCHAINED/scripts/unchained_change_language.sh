#!/bin/sh
echo $0 $*
progdir=`dirname "$0"`

whoami 

apt-get install -y language-pack-en
dpkg-reconfigure locales
update-locale LANG=en_US.UTF-8 LANGUAGE= LC_MESSAGES= LC_COLLATE= LC_CTYPE=