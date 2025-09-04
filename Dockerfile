FROM ubuntu:noble
LABEL maintainer="Alexandre Vanhecke <alexandre1.vanhecke@epitech.eu>"

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
        && apt-get update -y \
        && apt-get install -y --no-install-recommends software-properties-common apt-utils wget \
        && add-apt-repository -y -s universe \
        && add-apt-repository -y -s ppa:epitech/ppa \
        && wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/trusted.gpg.d/llvm.asc \
        && echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/llvm.asc] https://apt.llvm.org/noble/ llvm-toolchain-noble-20 main" | tee /etc/apt/sources.list.d/llvm.list \
        && apt-get update \
        && apt-get upgrade -y \
        && apt-get install -y \
        epitech-full \
        clang-20 \
        python3-clang-20 \
        locales \
        && apt-get clean -y \
        && rm -rf /var/lib/apt/lists/* \
        && rm -rf /usr/share/doc/*

RUN localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && npm install -g bun \
    && stack upgrade --force-download

ENV LANG=en_US.utf8 LANGUAGE=en_US:en LC_ALL=en_US.utf8 PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

WORKDIR /usr/app
