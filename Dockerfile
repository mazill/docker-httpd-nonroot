FROM centos:6.7

MAINTAINER "Matthias Zillmann"

USER root
RUN yum -y update && yum -y install httpd


USER 1001

EXPOSE 80

CMD ["/usr/sbin/httpd"]

