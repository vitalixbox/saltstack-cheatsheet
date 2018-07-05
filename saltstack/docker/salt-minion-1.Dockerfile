FROM ubuntu:16.04

RUN apt-get update -y
RUN apt-get install -y vim telnet curl iputils-ping wget

RUN wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add -
RUN echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main" > /etc/apt/sources.list.d/saltstack.list

RUN apt-get update -y
RUN apt-get install -y salt-minion

ADD etc/minion-1.conf /etc/salt/master

CMD /usr/bin/salt-minion
