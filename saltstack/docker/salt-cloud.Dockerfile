FROM ubuntu:16.04

RUN apt-get update -y
RUN apt-get install -y software-properties-common vim telnet curl iputils-ping
RUN add-apt-repository -y ppa:saltstack/salt
RUN apt-get install -y salt-cloud
