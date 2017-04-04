#!/bin/bash

set -ex
#NFILES=98000
NFILES=98000

# setup the docker command
RUN="docker run -it --rm --net host -v $HOME/.ssh:/root/.ssh -w /root"
ANSIBLE="michaelsevilla/ansible --forks 50 --skip-tags package-install,with_pkg"
CEPH_ANSIBLE="$RUN -v `pwd`/site/roles/ceph-ansible:/root $ANSIBLE"
SRL_ANSIBLE="$RUN -v `pwd`/site:/root $ANSIBLE"

#    for job in "creates" "creates-touchstream" "creates-stat" "creates-touch"; do
#for nclients in 2 3 4 5 6 7; do
  #for run in 0 1 2; do
      #for decoupled in 0 1; do
for nclients in 7; do
  site="journal-nocache"
  for run in 0; do
    for job in "scale-merge"; do
      for decoupled in 0; do
        # configure ceph and setup results directory
        results="$job-$nclients-decoupled-$decoupled/run$run"
        mkdir -p results/$results/logs || true
        cp site/* site/roles/ceph-ansible || true
        cp site_confs/${site}.yml site/group_vars/all
        cp -r site/group_vars site/roles/ceph-ansible/
        cp inventory/${nclients}client site/hosts
        cp inventory/${nclients}client site/roles/ceph-ansible/hosts
  
        # cleanup and start ceph
        $SRL_ANSIBLE cleanup.yml
        $CEPH_ANSIBLE ceph.yml #cephfs.yml
        $SRL_ANSIBLE ceph_pgs.yml ceph_wait.yml #ceph_monitor.yml
  
        # run job
#        ./ansible-playbook.sh -e site=$results -e nfiles=$NFILES -e drop_delay=30 ../workloads/scale-merge.yml
#        ./ansible-playbook.sh -e site=$results -e nfiles=$NFILES ../workloads/setup_mdtest.yml
#        if [ $decoupled -eq 1 ]; then
#          ./ansible-playbook.sh -e site=$results -e nfiles=$NFILES ../workloads/decouple.yml
#        fi
#        ./ansible-playbook.sh -e site=$results -e nfiles=$NFILES -e drop_delay=30 ../workloads/${job}.yml
#        ./ansible-playbook.sh -e site=$results collect.yml
      done
    done
  done
done
