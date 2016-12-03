#!/bin/bash
set -x
for w in "compile" "creates" "scale"; do
  cd $w
  ./run.sh
  cd -
done
