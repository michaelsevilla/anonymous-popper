#!/bin/bash

#set -x

echo "-- untar the journal"

DIR="kernel/journal/results-done"
SUBDIRS=`ls $DIR`
MDS="issdm-12"
for i in $SUBDIRS; do
  cd $DIR/$i
  echo "DIR=" `pwd`
  for j in `ls *.tar.gz`; do
    #tar xzf $j
    if [ $j == $MDS.tar.gz ]; then
      echo "... parsing MDS=$j"    
      for m in \
         "tmp/graphite/whisper/$MDS/mds_mem/ino.wsp" \
         "tmp/graphite/whisper/$MDS/mds_mem/ino+.wsp" \
         "tmp/graphite/whisper/$MDS/mds_mem/ino-.wsp" \
         "tmp/graphite/whisper/$MDS/mds/inodes.wsp" \
         "tmp/graphite/whisper/$MDS/mds/inodes_bottom.wsp" \
         "tmp/graphite/whisper/$MDS/mds/inodes_with_caps.wsp" \
         "tmp/graphite/whisper/$MDS/mds/inodes_pin_tail.wsp" \
         "tmp/graphite/whisper/$MDS/mds/inodes_pinned.wsp" \
         "tmp/graphite/whisper/$MDS/mds/inodes_top.wsp" \
         "tmp/graphite/whisper/$MDS/mds_server/handle_client_request_tput.wsp" \
         "tmp/graphite/whisper/$MDS/cputotals/user.wsp" \
         "tmp/graphite/whisper/$MDS/cputotals/sys.wsp" \
        ; do
        docker run -v `pwd`/tmp:/tmp --entrypoint=whisper-dump.py --rm \
          michaelsevilla/graphite ${m} > `basename ${m}`.out
        docker run -v `pwd`/:/tmp --entrypoint=/bin/bash --rm \
          michaelsevilla/graphite -c "sed -i \"s/:/,/g\" tmp/`basename $m`.out"
        echo "... ... `basename $m`"
      done
    fi
  done
  cd - >> /dev/null
done
