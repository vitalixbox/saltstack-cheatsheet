FROM ubuntu:16.04

RUN apt-get update -y
RUN apt-get install -y software-properties-common vim telnet curl iputils-ping
RUN add-apt-repository -y ppa:saltstack/salt
RUN apt-get install -y salt-minion
RUN rm /etc/apt/sources.list.d/saltstack-ubuntu-salt-xenial.list

ADD etc/minion-1.conf /etc/salt/master

CMD /usr/bin/salt-minion
