#!/bin/bash  

if [ -z $1 ]; then
  echo whatdoyawant?
  exit 1
fi

docker run \
  -v `pwd`/tmp:/tmp \
  --entrypoint=whisper-dump.py \
  michaelsevilla/graphite \
  /$1 > out
