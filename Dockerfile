# YOU CAN RUN THIS IMAGE WITH THE BELOW COMMAND
# docker run  --expose 9999 -p 9999:8888 ${IMAGE_ID}

# YOU CAN DOCKER BUILD THIS IMAGE IF YOU WANT TO MODIFY
# WITH THE BELOW COMMAND
# docker built -t docker-jupyter-ansible .

FROM centos:centos7.6.1810

# THIS DETERMINES YOUR THEME POSSIBLE OPTIONS ARE:
# onedork | grade3 | oceans16 | chesterish | monokai | solarizedl | solarizedd
ENV JUPY_THEME  monkai

# OTHER VARS
ENV EPEL_RPM   https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
ENV EPEL_SHO   epel-release-latest-7.noarch.rpm
ENV PYTHON_TGZ https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tgz
ENV PYTHON_VER Python-3.7.2
ENV SQLIT_TGZ  https://sqlite.org/2019/sqlite-autoconf-3270100.tar.gz
ENV SQLIT_VER  sqlite-autoconf-3270100

# OPEN PORT 8888 FOR LOCAL WEBAPP
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

# INSTALL SQLITE3
RUN wget -q      ${SQLIT_TGZ}        && \
    tar -xvzf    ${SQLIT_VER}.tar.gz && \
    cd           ${SQLIT_VER}        && \
    ./configure  && \
    make         && \
    make install && \
    cd ..        && \
    rm -rf ${SQLIT_VER}

# INSTALL PYTHON
RUN wget -q   ${PYTHON_TGZ}     && \
    tar  -xzf ${PYTHON_VER}.tgz && \
    cd        ${PYTHON_VER}     && \
    ./configure --with-zlib-dir=/usr/local/lib && \
    make         && \
    make install && \
    cd ..        && \
    rm -rf ${PYTHON_VER}*

# PIP INSTALL
RUN pip3 install --trusted-host pypi.org --upgrade pip && \
    pip3 install --trusted-host \
        pypi.org       \
        jupyter        \
        jupyterthemes  \
        ansible-kernel

# SETUP JUPYTER
RUN jt -t   ${JUPY_THEME} && \
    adduser jupyter       && \
    mkdir   /jupyter      && \
    chown   jupyter:jupyter /jupyter

# SETUP JUPYTER USER
USER jupyter

# SETUP JUPYTER RUNTIME
CMD cd /jupyter && \
    jupyter-notebook --ip=0.0.0.0

