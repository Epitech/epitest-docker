FROM ubuntu:resolute
LABEL maintainer="Alexandre Vanhecke <alexandre1.vanhecke@epitech.eu>"

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
        && apt-get update -y \
        && apt-get install -y --no-install-recommends software-properties-common apt-utils wget \
        && add-apt-repository -y -s universe \
        && add-apt-repository -y -s ppa:epitech/ppa \
        && apt-get update \
        && apt-get upgrade -y \
        && apt-get install -y \
        clang-21 \
        python3-clang-21 \
        locales

# Previously epitech-full was installed in the previous layer, now its dependencies are in split layers for performance reasons
RUN apt-get install -y epitech-cpool
RUN apt-get install -y epitech-premsc
RUN apt-get install -y epitech-tek1
RUN apt-get install -y epitech-tek2
RUN apt-get install -y epitech-web

RUN apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/share/doc/*

RUN localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && stack upgrade --force-download \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-21 100 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-21 100 \
    && update-alternatives --install /usr/bin/scan-build scan-build /usr/bin/scan-build-21 100 \
    && update-alternatives --install /usr/bin/llvm-cov llvm-cov /usr/bin/llvm-cov-21 900

# Layer to update banana (and epiclang) only, check version at https://launchpad.net/~epitech/+archive/ubuntu/ppa
RUN apt-get update -y \
    && apt-get install -y banana-coding-style-checker=20260908140840 epiclang=20260908135112 \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/share/doc/*

ENV LANG=en_US.utf8 LANGUAGE=en_US:en LC_ALL=en_US.utf8 PKG_CONFIG_PATH=/usr/local/lib/pkgconfig CC=clang CXX=clang++ JUPYTER_DATA_DIR=/tmp JUPYTER_RUNTIME_DIR=/tmp MPLCONFIGDIR=/tmp

WORKDIR /usr/app
