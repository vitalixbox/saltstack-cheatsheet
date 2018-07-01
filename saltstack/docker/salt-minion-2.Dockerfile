FROM fedora:27

RUN yum -y update
RUN yum -y install salt-minion vim curl iputils

ADD etc/minion-2.conf /etc/salt/master

CMD /usr/bin/salt-minion
