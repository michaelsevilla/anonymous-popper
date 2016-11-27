#!/bin/bash

set -x

# If you want to test non-MDS0
#ssh issdm-12 "docker exec cephfs mkdir /cephfs/testdir"
#ssh issdm-12 "docker exec cephfs touch /cephfs/testdir/blah"
#ssh issdm-12 "docker exec ceph-issdm-12-mds ceph daemon mds.issdm-12 export dir /testdir 1"
#sleep 30
#./ceph-mds-admin-daemon.sh "get subtrees | grep -B4 path | grep \"path\|is_auth\""
#read -n1 -r -p "Press space to continue..." key

key=''

if [ "$key" = '' ]; then
  for i in 0 1 2; do 
    ./ansible-playbook.sh -e nfiles=100000 ../workloads/metawrites.yml
  done
fi
