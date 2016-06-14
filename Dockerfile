FROM centos:6.7

MAINTAINER "Matthias Zillmann"

USER root

RUN yum -y update 

RUN yum -y install httpd


USER default

/usr/sbin/httpd
