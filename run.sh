#!/bin/bash
set -x
for w in "scale"; do
  cd $w
  ./run.sh
  cd -
done
