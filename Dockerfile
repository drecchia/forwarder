FROM debian:wheezy

MAINTAINER Danilo Recchia <danilo@deltatecnologia.com>

ENV LISTEN_PORT 1521,3306,8161
ENV LISTEN_PROTO tcp,tcp,tcp
ENV TARGET 192.168.128.6,sqlserver,jmssever
ENV TARGET_PORT 1521,3306,8161

RUN apt-get update && apt-get install -y \
    bridge-utils \
    net-tools \
    iptables 

ADD files/runme.sh /runme.sh
ADD files/iptables.sh /iptables.sh

RUN chmod +x /*.sh

ENTRYPOINT /runme.sh 
