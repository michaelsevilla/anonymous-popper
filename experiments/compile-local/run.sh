#!/bin/bash

set -ex
sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"


docker rm -f test fuse || true
sudo umount /mnt/test || true
docker run -d --name fuse -v /mnt/test:/mnt/test:shared -it --privileged test

for i in 0 1 2; do
  ./ansible-playbook.sh -e "site=fuse" ../workloads/compile.yml
done

