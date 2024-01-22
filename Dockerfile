FROM ubuntu:22.04

MAINTAINER Red Z <rabbired@outlook.com>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt -y upgrade && \
    apt install -y --assume-yes \
    asciidoc \
    sudo && \
    mkdir /opt/opbuild /opt/binwalk && \
    useradd -d /opt/opbuild -s /bin/bash opbuild && \
    chown -R opbuild:opbuild /opt/opbuild && \
    echo "opbuild ALL=(ALL:ALL) NOPASSWD:ALL"  >> /etc/sudoers && \
 echo "**** cleanup ****" && \
 apt-get autoremove && \
 apt-get clean && \
 rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

RUN apt update && apt install -y --assume-yes \
    binutils \
    bzip2 \
    gawk \
    gettext \
    git && \
 echo "**** cleanup ****" && \
 apt-get autoremove && \
 apt-get clean && \
 rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

RUN apt update && apt install -y --assume-yes \
    ack antlr3 asciidoc autoconf automake autopoint binutils bison build-essential \
    bzip2 ccache cmake cpio curl device-tree-compiler fastjar flex gawk gettext gcc-multilib g++-multilib \
    git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libfuse-dev libglib2.0-dev libgmp3-dev \
    libltdl-dev libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libpython3-dev libreadline-dev \
    libssl-dev libtool lrzsz mkisofs msmtp ninja-build p7zip p7zip-full patch pkgconf python2.7 python3 \
    python3-pyelftools python3-setuptools qemu-utils rsync scons squashfs-tools subversion swig texinfo \
    uglifyjs upx-ucl unzip vim wget xmlto xxd zlib1g-dev gperf wget curl swig rsync nano python3-pip && \
 echo "**** cleanup ****" && \
 apt-get autoremove && \
 apt-get clean && \
 rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

RUN apt update && apt -y upgrade && \
    echo "opbuild ALL=(ALL:ALL) NOPASSWD:ALL"  >> /etc/sudoers && \
    python3 -m pip install --upgrade --force pip && \
    ln -s /usr/local/bin/pip /bin/pip && \
    git clone https://github.com/ReFirmLabs/binwalk.git /opt/binwalk && \
    cd /opt/binwalk && \
    ./deps.sh --yes && \
    ln -s /usr/local/bin/binwalk /bin/binwalk && \
    rm -rf /opt/binwalk && \
 echo "**** cleanup ****" && \
 apt-get autoremove && \
 apt-get clean && \
 rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

WORKDIR /opt/opbuild
USER opbuild
