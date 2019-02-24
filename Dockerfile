FROM centos:centos7.6.1810

ENV EPEL_RPM https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# INSTALL BASE DEPENDENCIES
RUN yum update  -y && \
    yum install -y python-devel git wget

# DOWNLOAD AND INSTALL EPEL
RUN wget ${EPEL_RPM} && \
    rm   ${EPEL_RPM##*/}

RUN yum install -y ./epel-release-latest-7.noarch.rpm && \
    rm ./epel-release-latest-7.noarch.rpm

# INSTALL PIP
RUN yum update && \
    yum install -y python-pip

# PIP INSTALL
RUN pip install --upgrade pip && \
    pip install jupyter jupyterthemes ansible-kernel

RUN adduser jupyter
