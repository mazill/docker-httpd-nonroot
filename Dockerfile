FROM openshift/base-centos7

RUN yum -y update && yum clean all
ENV HOME=/opt/app-root/src 
	
# This is the list of basic dependencies that all language Docker image can consume.
# Also setup the 'openshift' user that is used for the build execution and for the
# application runtime execution.
# TODO: Use better UID and GID values
RUN \ 
  INSTALL_PKGS="\
  patch \
  httpd\
  tar \
  unzip \
  rsync \
  wget \
  which \
  yum-utils" && \
  yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
  rpm -V $INSTALL_PKGS && \
  yum clean all -y && \
  mkdir -p ${HOME} 

RUN getent passwd 1001 || useradd -u 1001 -r -g 0 -d ${HOME} -s /sbin/nologin -c "Default Application User" default

# Ports
COPY httpd/ /etc/httpd/
EXPOSE 8080

  
# get rid of the root user and set permissons	
RUN	chown -R 1001:0 ${HOME} && \
	chmod -R ug+rwx ${HOME} && \
	mkdir -p /run/httpd && \
        chown -R 1001:0 /run/httpd/ && \
	mkdir -p /var/www && \
	chown -R 1001:0 /var/www && \
        chown -R 1001:0 /etc/httpd && \
	mkdir -p /var/log/httpd && \
        chown -R 1001:0 /var/log/httpd && \
	chmod -R ug+rwx /var/log/httpd


WORKDIR ${HOME}
	
#VOLUME ["/var/www", "/var/log/httpd", "/etc/httpd"]

USER 1001
# EXEC
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]

