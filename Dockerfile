FROM ubuntu:18.04

MAINTAINER Red Z <rabbired@outlook.com>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt -y upgrade && \
  apt install -y --assume-yes build-essential ccache ecj fastjar file g++ gawk \
  gettext git java-propose-classpath libelf-dev libncurses5-dev \
  libncursesw5-dev libssl-dev python python2.7-dev python3 unzip wget \
  python3-distutils python3-setuptools python3-dev rsync subversion swig time \
  xsltproc zlib1g-dev && \
   mkdir /opt/opbuild /opt/binwalk && \
   useradd -d /opt/opbuild -s /bin/bash opbuild && \
   chown -R opbuild:opbuild /opt/opbuild && \
   echo "opbuild ALL=(ALL:ALL) NOPASSWD:ALL"  >> /etc/sudoers && \
     apt-get autoremove && \
     apt-get clean && \
     rm -rf \
        /tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

RUN echo "opbuild ALL=(ALL:ALL) NOPASSWD:ALL"  >> /etc/sudoers && \
    pip3 --no-cache-dir install -U pip && \
    if [[ ! -e /usr/local/bin/pip3 ]]; then ln -sf /usr/local/bin/pip3 /bin/pip; fi && \
    git clone https://github.com/ReFirmLabs/binwalk.git /opt/binwalk && \
    cd /opt/binwalk && \
    ./deps.sh --yes && \
    if [[ ! -e /usr/local/bin/binwalk ]]; then ln -sf /usr/local/bin/binwalk /bin/binwalk; fi && \
    rm -rf /opt/binwalk && \
 apt-get autoremove && \
 apt-get clean && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

WORKDIR /opt/opbuild
USER opbuild
