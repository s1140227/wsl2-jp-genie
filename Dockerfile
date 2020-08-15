FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Tokyo

RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg

# http://ubuntulinux.jp/japanese
RUN wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- | apt-key add - && \
    wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- | apt-key add - && \
    wget https://www.ubuntulinux.jp/sources.list.d/focal.list -O /etc/apt/sources.list.d/ubuntu-ja.list

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    vim \
    git \
    xclip \
    x11-apps \
    ubuntu-defaults-ja \
    fcitx \
    fcitx-mozc

RUN update-locale LANG=ja_JP.UTF8

ADD default.sh ./
RUN cat default.sh >> ~/.bashrc

# https://github.com/arkane-systems/genie

# https://docs.microsoft.com/ja-jp/dotnet/core/install/linux-ubuntu#1804-
# https://launchpad.net/~ubuntu-toolchain-r/+archive/ubuntu/test
RUN wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv 60C317803A41BA51845E371A1E9377A2BA9EF27F && \
    echo "deb http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu focal main " > /etc/apt/sources.list.d/gcc-10.list && \
    echo "deb-src http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu focal main " >> /etc/apt/sources.list.d/gcc-10.list && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y apt-transport-https && \
    apt-get update && \
    apt-get install -y \
        dotnet-sdk-3.1 \
        dotnet-runtime-3.1

RUN curl -s https://packagecloud.io/install/repositories/arkane-systems/wsl-translinux/script.deb.sh | bash && \
    apt-get install -y \
        systemd-genie \
        snapd

CMD ["/bin/bash"]