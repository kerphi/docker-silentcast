FROM ubuntu:14.04
MAINTAINER Stéphane Gully

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install bash
RUN apt-get -y install libav-tools
RUN apt-get -y install imagemagick
RUN apt-get -y install x11-xserver-utils
RUN apt-get -y install xdotool
RUN apt-get -y install wininfo
RUN apt-get -y install wmctrl
RUN apt-get -y install python-gobject
RUN apt-get -y install python-cairo
RUN apt-get -y install xdg-utils
RUN apt-get -y install sudo
RUN apt-get -y install software-properties-common
RUN apt-get -y install desktop-file-utils

RUN add-apt-repository ppa:sethj/silentcast
RUN apt-get update
RUN apt-get install -y silentcast

RUN apt-get -y install wget

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/silentcast && \
    echo "silentcast:x:${uid}:${gid}:Silentcast User,,,:/home/silentcast:/bin/bash" >> /etc/passwd && \
    echo "silentcast:x:${uid}:" >> /etc/group && \
    echo "silentcast ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/silentcast && \
    chmod 0440 /etc/sudoers.d/silentcast && \
    chown ${uid}:${gid} -R /home/silentcast

USER silentcast
ENV HOME /home/silentcast

WORKDIR /home/silentcast/
RUN wget https://github.com/colinkeenan/silentcast/archive/v2.2.tar.gz -O /home/silentcast/silentcast-2.2.tar.gz
RUN tar xzf silentcast-2.2.tar.gz

CMD [ '/home/silentcast/silentcast-2.2/silentcast' ]