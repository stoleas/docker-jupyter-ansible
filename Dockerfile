FROM centos:centos7.6.1810

ENV EPEL_RPM   https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
ENV EPEL_SHO   epel-release-latest-7.noarch.rpm
ENV PYTHON_TGZ https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tgz
ENV PYTHON_VER Python-3.7.2
ENV SQLIT_TGZ  https://sqlite.org/2019/sqlite-autoconf-3270100.tar.gz
ENV SQLIT_VER  sqlite-autoconf-3270100

EXPOSE 8888

# INSTALL BASE DEPENDENCIES
RUN yum update  -y && \
    yum install -y    \
        git           \
        wget          \
        gcc           \
        make          \
        zlib          \
        zlib-devel    \
        libffi-devel  \
        openssl       \
        openssl-devel

# INSTALL PYTHON
RUN wget -q   ${PYTHON_TGZ}     && \
    tar  -xzf ${PYTHON_VER}.tgz && \
    cd        ${PYTHON_VER}     && \
    ./configure --with-zlib-dir=/usr/local/lib && \
    make         && \
    make install && \
    cd ..        && \
    rm -rf ${PYTHON_VER}*

# INSTALL SQLITE3
RUN wget -q      ${SQLIT_TGZ}        && \
    tar -xvzf    ${SQLIT_VER}.tar.gz && \
    cd           ${SQLIT_VER}        && \
    ./configure  && \
    make         && \
    make install && \
    cd ..        && \
    rm -rf ${SQLIT_VER}

# PIP INSTALL
RUN pip3 install --trusted-host pypi.org --upgrade pip && \
    pip3 install --trusted-host \
        pypi.org       \
        jupyter        \
        jupyterthemes  \
        ansible-kernel

# SETUP JUPYTER
RUN jt -t monokai

CMD jupyter-notebook --ip=0.0.0.0
#RUN adduser jupyter
