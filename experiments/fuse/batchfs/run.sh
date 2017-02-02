#!/bin/bash

set -ex

# setup the docker command
RUN="docker run -it --rm --net host -v $HOME/.ssh:/root/.ssh -w /root"
ANSIBLE="michaelsevilla/ansible --forks 50 --skip-tags package-install,with_pkg"
CEPH_ANSIBLE="$RUN -v `pwd`/site/roles/ceph-ansible:/root $ANSIBLE"
SRL_ANSIBLE="$RUN -v `pwd`/site:/root $ANSIBLE"

# configure ceph and setup results directory
cp site/* site/roles/ceph-ansible || true
cp -r site/group_vars site/roles/ceph-ansible/
cp site/hosts site/roles/ceph-ansible/hosts

# cleanup and start ceph
for i in "bogus"; do
  for nfiles in 100000; do # 10000 1000 100 10; do
    mkdir -p results/${nfiles}/logs || true
    $SRL_ANSIBLE cleanup.yml
    $CEPH_ANSIBLE ceph.yml cephfs.yml
    $SRL_ANSIBLE ceph_pgs.yml ceph_monitor.yml ceph_wait.yml
     
    ./ansible-playbook.sh -e nfiles=$nfiles ../workloads/journal.yml
    ./ansible-playbook.sh -e site=$nfiles collect.yml
  done
  mv results results-run${i}
done
