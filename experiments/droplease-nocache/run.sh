#!/bin/bash

set -x

# setup the docker command
RUN="docker run -it --rm --net host -v $HOME/.ssh:/root/.ssh -w /root"
ANSIBLE="michaelsevilla/ansible --forks 50 --skip-tags package-install,with_pkg"
CEPH_ANSIBLE="$RUN -v `pwd`/site/roles/ceph-ansible:/root $ANSIBLE"
SRL_ANSIBLE="$RUN -v `pwd`/site:/root $ANSIBLE"

# move configuration files
cp site/* site/roles/ceph-ansible || true
cp -r site/group_vars site/roles/ceph-ansible/

# cleanup and start ceph
$SRL_ANSIBLE cleanup.yml
$CEPH_ANSIBLE ceph.yml cephfs.yml
$SRL_ANSIBLE ceph_pgs.yml ceph_monitor.yml ceph_wait.yml

# warmup and get baseline
for i in `seq 0 3`; do
  ./ansible-playbook.sh -e nfiles=100000 ../workloads/creates.yml
done

# baseline the drop delays
for i in 2 4 6; do
  ./ansible-playbook.sh -e nfiles=100000 -e drop_delay=${i} ../workloads/stat.yml
done

# scale the length fo the test (do we see open/close spike?)
for i in 10000 50000 100000; do
  ./ansible-playbook.sh -e nfiles=${i} ../workloads/creates.yml
done

./ansible-playbook.sh collect.yml
