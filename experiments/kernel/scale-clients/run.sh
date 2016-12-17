#!/bin/bash

set -ex

# setup the docker command
RUN="docker run -it --rm --net host -v $HOME/.ssh:/root/.ssh -w /root"
ANSIBLE="michaelsevilla/ansible --forks 50 --skip-tags package-install,with_pkg"
CEPH_ANSIBLE="$RUN -v `pwd`/site/roles/ceph-ansible:/root $ANSIBLE"
SRL_ANSIBLE="$RUN -v `pwd`/site:/root $ANSIBLE"

#for site in 8 1 2 3 4 5 6 7 8; do
for site in "journal" "nojournal" "nocache"; do
  nclients=3

  # configure ceph and setup results directory
  mkdir -p results/$site/logs || true
  cp site/* site/roles/ceph-ansible || true
  cp -r site/group_vars site/roles/ceph-ansible/
  cp ${site}.yml site/group_vars/all
  cp inventory/${nclients}client site/hosts
  cp inventory/${nclients}client site/roles/ceph-ansible/hosts

  # cleanup and start ceph
  $SRL_ANSIBLE cleanup.yml
  $CEPH_ANSIBLE ceph.yml cephfs.yml
  $SRL_ANSIBLE ceph_pgs.yml ceph_monitor.yml ceph_wait.yml
  
  # warmup and get baseline
  for i in `seq 0 2`; do
    ./ansible-playbook.sh -e site=$site -e nfiles=100000 ../workloads/creates.yml
  done
  
  ## baseline the drop delays
  #./ansible-playbook.sh -e site=$site -e nfiles=50000 -e drop_delay=15 ../workloads/stat.yml
  #./ansible-playbook.sh -e site=$site -e nfiles=50000 -e drop_delay=15 ../workloads/touch.yml

  ./ansible-playbook.sh -e site=$site collect.yml
done
