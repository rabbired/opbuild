FROM ubuntu:18.04

MAINTAINER Red Z <rabbired@outlook.com>

ARG DEBIAN_FRONTEND=noninteractive

RUN	apt update && apt -y upgrade && \
    apt install -y --assume-yes \
    asciidoc \
    sudo && \
    mkdir /opt/opbuild /opt/binwalk && \
    useradd -d /opt/opbuild -s /bin/bash opbuild && \
    chown -R opbuild:opbuild /opt/opbuild && \
    echo "opbuild ALL=(ALL:ALL) NOPASSWD:ALL"  >> /etc/sudoers

RUN apt install -y --assume-yes \
    binutils \
    bzip2 \
    gawk \
    gettext \
    git

RUN apt install -y --assume-yes \
    libncurses5-dev \
    libz-dev \
    patch \
    python3 \
    python2.7 \
    unzip \
    zlib1g-dev \
    lib32gcc1 \
    libc6-dev-i386 \
    subversion \
    flex \
    uglifyjs \
    git-core \
    gcc-multilib \
    p7zip \
    p7zip-full \
    msmtp \
    libssl-dev \
    texinfo \
    libglib2.0-dev \
    xmlto \
    qemu-utils \
    upx \
    libelf-dev \
    autoconf \
    automake \
    libtool \
    autopoint \
    device-tree-compiler \
    g++-multilib \
    antlr3 \
    gperf \
    wget \
    curl \
    swig \
    rsync \
    nano \
    python3-pip

RUN echo "opbuild ALL=(ALL:ALL) NOPASSWD:ALL"  >> /etc/sudoers && \
    python3 -m pip install --upgrade --force pip && \
    ln -s /usr/local/bin/pip /bin/pip && \
    git clone https://github.com/ReFirmLabs/binwalk.git /opt/binwalk && \
    cd /opt/binwalk && \
    ./deps.sh --yes && \
    ln -s /usr/local/bin/binwalk /bin/binwalk && \
    rm -rf /opt/binwalk && \
    apt -q -y autoremove && \
	apt -q -y clean && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /opt/opbuild
USER opbuild
