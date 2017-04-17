# images

This directory creates a Docker image with customized Ceph binaries:

1. change [line 23](https://github.com/michaelsevilla/anonymous-popper/blob/master/images/ceph/build.sh#L23) of build.sh to match your git commit

2. change [line 24](https://github.com/michaelsevilla/anonymous-popper/blob/master/images/ceph/build.sh#L24) of build.sh to match your git repo

3. change [lines 35-37](https://github.com/michaelsevilla/anonymous-popper/blob/master/images/ceph/build.sh#L35) of build.sh to match your git commit

4. change [line 1](https://github.com/michaelsevilla/anonymous-popper/blob/master/images/ceph/Dockerfile#L1) of Dockerfile to match your new image name from step 3

## Extra notes

- entrypoint.sh: builds against a Ceph directory 

- Dockerfile: installs dependencies
