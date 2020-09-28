FROM ubuntu:18.04 as build

MAINTAINER Red Z <rabbired@outlook.com>

RUN mkdir /opt/opbuild /opt/binwalk && \
        useradd -d /opt/opbuild -s /bin/bash opbuild && \
        chown -R opbuild:opbuild /opt/opbuild

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y upgrade && \
	apt install -y --assume-yes build-essential asciidoc binutils bzip2 gawk gettext git

RUN apt-get update && apt-get -y upgrade && \
        apt install -y --assume-yes libncurses5-dev libz-dev patch unzip zlib1g-dev \
	lib32gcc1 libc6-dev-i386 subversion

RUN apt-get update && apt-get -y upgrade && \
        apt install -y --assume-yes flex uglifyjs git-core gcc-multilib p7zip \
    p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx \
    libelf-dev autoconf automake libtool autopoint device-tree-compiler \
    g++-multilib antlr3 gperf wget curl swig rsync nano wget python python3 python3-pip && \
        python3 -m pip install --upgrade --force pip && \
        ln -s /usr/local/bin/pip /bin/pip

RUN git clone https://github.com/ReFirmLabs/binwalk.git /opt/binwalk && \
        apt-get update && \
        cd /opt/binwalk && \
        python3 setup.py install && \
        ./deps.sh --yes && \
        ln -s /usr/local/bin/binwalk /bin/binwalk && \
        rm -rf /opt/binwalk && \
RUN	apt-get -q -y autoremove && \
	apt-get -q -y clean && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /opt/opbuild
