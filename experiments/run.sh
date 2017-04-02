#!/bin/bash
set -x
#for w in "droplease-cache" "droplease-nocache"; do
#for w in "droplease-cache-creates" "droplease-nocache-creates"; do
for w in "fuse/scale-clients-isolated" "fuse/scale-merge"; do
  cd $w
  ./run.sh
  cd -
done
