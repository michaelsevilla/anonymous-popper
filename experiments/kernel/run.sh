#!/bin/bash
set -x
for w in "droplease-cache" "droplease-nocache"; do
  cd $w
  ./run.sh
  cd -
done
