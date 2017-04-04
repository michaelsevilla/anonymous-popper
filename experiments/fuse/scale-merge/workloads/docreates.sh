#!/bin/bash
set -ex
INO=$1
docker exec cephfs cephfs-journal-tool event create list --nfiles 10 --persist true --decoupled_dir dir-$HOSTNAME --file /etc/ceph/events-$HOSTNAME.bin --start_ino $INO
