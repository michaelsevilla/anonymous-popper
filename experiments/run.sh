#!/bin/bash
set -x
#for w in "droplease-cache" "droplease-nocache"; do
for w in "droplease-cache-creates" "droplease-nocache-creates"; do
  cd $w
  ./run.sh
  cd -
done
