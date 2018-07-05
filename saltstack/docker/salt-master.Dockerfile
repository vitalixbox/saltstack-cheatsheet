FROM ubuntu:16.04

RUN apt-get update -y
RUN apt-get install -y vim telnet curl iputils-ping wget

RUN wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add -
RUN echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main" > /etc/apt/sources.list.d/saltstack.list

RUN apt-get update -y
RUN apt-get install -y salt-master salt-cloud

ADD etc/master.conf /etc/salt/master
ADD etc/cluster.map /etc/salt/cluster.map
ADD etc/digitalocean.conf /etc/salt/cloud.providers.d/digitalocean.conf
ADD etc/ubuntu.conf /etc/salt/cloud.profiles.d/ubuntu.conf
ADD salt /srv/salt
ADD pillar /srv/pillar

CMD /usr/bin/salt-master
