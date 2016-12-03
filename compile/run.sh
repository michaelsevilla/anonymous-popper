#!/bin/bash

set -ex

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

for i in 0 1 2; do
  ./ansible-playbook.sh -e "threads=1" ../workloads/compile.yml
  ./ansible-playbook.sh -e "threads=2" ../workloads/compile.yml
  ./ansible-playbook.sh -e "threads=3" ../workloads/compile.yml
  ./ansible-playbook.sh -e "threads=4" ../workloads/compile.yml
  ./ansible-playbook.sh -e "threads=5" ../workloads/compile.yml
  ./ansible-playbook.sh -e "threads=6" ../workloads/compile.yml
  ./ansible-playbook.sh -e "threads=7" ../workloads/compile.yml
  ./ansible-playbook.sh -e "threads=8" ../workloads/compile.yml
done

./ansible-playbook.sh collect.yml
