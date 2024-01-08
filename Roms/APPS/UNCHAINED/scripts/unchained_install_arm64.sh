#!/bin/sh
echo $0 $*
progdir=`dirname "$0"`

whoami 

dpkg --add-architecture arm64

apt-get update -y 
apt update -y 
apt upgrade -y 
apt-get install -y aptitude 

# libgcc1 depends on gcc-8-base and libc6
# those packages are conflicting with other packages
# therefore they cant get easily installed with apt-get
# but aptitude can downgrade other pagackages to make it work easily
aptitude install libgcc1:arm64

$progdir/../bin/binArm32HFp
$progdir/../bin/binArm64