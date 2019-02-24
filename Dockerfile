FROM centos:centos7.6.1810

ENV EPEL_RPM   https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
ENV EPEL_SHO   epel-release-latest-7.noarch.rpm
ENV PYTHON_TGZ https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tgz
ENV PYTHON_VER Python-3.7.2

# INSTALL BASE DEPENDENCIES
RUN yum update  -y && \
    yum install -y git wget gcc make

# INSTALL PYTHON
RUN wget -q   ${PYTHON_TGZ} && \
    tar  -xzf ${PYTHON_VER}.tgz && \
    cd        ${PYTHON_VER} && \
    ./configure  && \
    make         && \
    make install && \
    cd ..        && \
    rm -rf ${PYTHON_VER}*

# DOWNLOAD AND INSTALL EPEL
RUN wget ${EPEL_RPM} && \
    yum install -y ${EPEL_SHO} ; \
    rm ${EPEL_SHO}

## INSTALL PIP
#RUN yum update && \
#    yum install -y python-pip
#
## PIP INSTALL
#RUN pip install --upgrade pip && \
#    pip install jupyter jupyterthemes ansible-kernel
#
#RUN adduser jupyter
