FROM tutum/ubuntu:trusty

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y xz-utils libncurses5-dev gcc make git exuberant-ctags bc libssl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* debian/

ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
