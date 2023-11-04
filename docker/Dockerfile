FROM debian:11
MAINTAINER "Nikita Voronchev <n.voronchev@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        dumb-init \
        gawk \
        gosu \
        inkscape \
        make \
    && rm -rf /var/cache/apt/archives/*

ARG SRC_MOUNT
ENV SRC_MOUNT=${SRC_MOUNT}

COPY entrypoint.sh /
ENTRYPOINT ["/usr/bin/dumb-init", "--", "/entrypoint.sh"]
