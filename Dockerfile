FROM centos:centos7.6.1810

ENV EPEL_RPM   https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
ENV PYTHON_TGZ https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tgz

# INSTALL BASE DEPENDENCIES
RUN yum update  -y && \
    yum install -y git wget gcc tar

# INSTALL PYTHON
RUN wget ${PYTHON_TGZ} && \
    tar -xz ${PYTHON_TGZ%%*/} && \


# DOWNLOAD AND INSTALL EPEL
RUN wget ${EPEL_RPM} && \
    yum install -y ${EPEL_RPM%%*/} ; \
    rm ${EPEL_RPM%%*/}

# INSTALL PIP
RUN yum update && \
    yum install -y python-pip

# PIP INSTALL
RUN pip install --upgrade pip && \
    pip install jupyter jupyterthemes ansible-kernel

RUN adduser jupyter
