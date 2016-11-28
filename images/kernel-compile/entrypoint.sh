#!/bin/bash

set -x

if [ -z $CORES ]; then
  CORES=3
fi

if [ -z $DIR ]; then
  DIR=/cephfs/"`hostname`"-compile
fi

if [ -z $CONFIG ]; then
  CONFIG="allnoconfig"
fi

mkdir $DIR
cd $DIR
wget https://cdn.kernel.org/pub/linux/kernel/v4.x/testing/linux-4.9-rc6.tar.xz
tar xvf linux-4.9-rc6.tar.xz
cd linux-4.9-rc6
make $CONFIG
make -j3
