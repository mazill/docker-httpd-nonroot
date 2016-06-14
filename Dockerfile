FROM centos:6.7

MAINTAINER "Matthias Zillmann"

USER root

RUN yum -y update 

RUN yum -y install httpd


USER apache

/usr/sbin/httpd

EXPOSE 80
