FROM tutum/ubuntu:trusty

RUN apt-get update -y && \
    apt-get install make gcc -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* debian/ && \
    wget https://github.com/libfuse/libfuse/releases/download/fuse-3.0.0-rc2/fuse-3.0.0rc2.tar.gz && \
    tar xzvf fuse-3.0.0rc2.tar.gz && \
    cd /fuse-3.0.0rc2/ && \
    ./configure && make && make install 

ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
