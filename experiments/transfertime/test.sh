#!/bin/bash


set -ex

ino=1099511628877

# generate
#for i in `seq 1 24`; do
#  ino=$((ino+98000))
#  docker exec ceph-issdm-12-mds cephfs-journal-tool event create summary --nfiles 98000 --persist true --decoupled_dir dir$i --file /etc/ceph/$i-100k.bin --start_ino $ino >> log.txt 2>&1
#done

#for i in `seq 1 24`; do
#  ino=$((ino+50000))
#  docker exec ceph-issdm-12-mds cephfs-journal-tool event create summary --nfiles 50000 --persist true --decoupled_dir dir$i --file /etc/ceph/$i-50k.bin --start_ino $ino >> log.txt 2>&1
#done
#
#for i in `seq 1 24`; do
#  ino=$((ino+1000))
#  docker exec ceph-issdm-12-mds cephfs-journal-tool event create summary --nfiles 1000 --persist true --decoupled_dir dir$i --file /etc/ceph/$i-1k.bin --start_ino $ino >> log.txt 2>&1
#done

#rm -r results || true
mkdir results 
#for i in `seq 1 24`; do
#  /usr/bin/time --format="%e" docker exec ceph-issdm-12-mds ceph daemon mds.issdm-12 merge /etc/ceph/$i-1k.bin >> results/log-1k 2>> results/summary-1k
#  sleep 10
#done

#for i in `seq 1 24`; do
#  /usr/bin/time --format="%e" docker exec ceph-issdm-12-mds ceph daemon mds.issdm-12 merge /etc/ceph/$i-50k.bin >> results/log-50k 2>> results/summary-50k
#  sleep 10
#done

for i in `seq 1 24`; do
  /usr/bin/time --format="%e" docker exec ceph-issdm-12-mds ceph daemon mds.issdm-12 merge /etc/ceph/$i-100k.bin >> results/log-100k 2>> results/summary-100k
  sleep 20
done
