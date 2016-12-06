#!/bin/bash

set -ex

# setup the docker command
RUN="docker run -it --rm --net host -v $HOME/.ssh:/root/.ssh -w /root"
ANSIBLE="michaelsevilla/ansible --forks 50 --skip-tags package-install,with_pkg"
CEPH_ANSIBLE="$RUN -v `pwd`/site/roles/ceph-ansible:/root $ANSIBLE"
SRL_ANSIBLE="$RUN -v `pwd`/site:/root $ANSIBLE"

for site in "cache" "nocache"; do
  # configure ceph and setup results directory
  mkdir -p results/$site/logs || true
  cp site/* site/roles/ceph-ansible || true
  cp -r site/group_vars site/roles/ceph-ansible/
  cp ${site}.yml site/group_vars/all

  # cleanup and start ceph
  $SRL_ANSIBLE  cleanup.yml
  $CEPH_ANSIBLE ceph.yml cephfs.yml
  $SRL_ANSIBLE  ceph_pgs.yml ceph_monitor.yml ceph_wait.yml
  
  # warmup and get baseline
  for i in `seq 0 3`; do
    ./ansible-playbook.sh -e nfiles=100000 ../workloads/creates.yml
  done
  
  # baseline the drop delays
  for i in `seq 0 2`; do
    for j in 2 4 6; do
      ./ansible-playbook.sh -e site=$site -e nfiles=1000000 -e drop_delay=${j} ../workloads/stat.yml
      ./ansible-playbook.sh -e site=$site -e nfiles=1000000 -e drop_delay=${j} ../workloads/touch.yml
    done
  done
  ./ansible-playbook.sh -e site=$site collect.yml
done
