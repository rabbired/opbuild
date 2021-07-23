FROM ubuntu:20.04

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

RUN apt update && apt -y upgrade && \
  apt-get -y --assume-yes install build-essential \
  asciidoc binutils bzip2 gawk gettext \
  git libncurses5-dev libz-dev patch \
  python3 python2.7 unzip zlib1g-dev \
  lib32gcc1 libc6-dev-i386 subversion \
  flex uglifyjs git-core gcc-multilib \
  p7zip p7zip-full msmtp libssl-dev \
  texinfo libglib2.0-dev xmlto qemu-utils \
  upx libelf-dev autoconf automake libtool \
  autopoint device-tree-compiler g++-multilib \
  antlr3 gperf wget curl swig rsync python3 \
  python3-pip && \
  if [[ ! -e /usr/local/bin/pip3 ]]; then ln -sf /usr/local/bin/pip3 /bin/pip; fi && \
     apt-get autoremove && \
     apt-get clean && \
     rm -rf \
        /tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

RUN echo "opbuild ALL=(ALL:ALL) NOPASSWD:ALL"  >> /etc/sudoers && \
    pip3 --no-cache-dir install -U pip && \
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
