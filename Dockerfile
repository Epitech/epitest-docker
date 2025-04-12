FROM ubuntu:mantic
LABEL maintainer="Alexandre Vanhecke <alexandre1.vanhecke@epitech.eu>"

RUN echo "deb http://old-releases.ubuntu.com/ubuntu/ mantic main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb http://old-releases.ubuntu.com/ubuntu/ mantic-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://old-releases.ubuntu.com/ubuntu/ mantic-security main restricted universe multiverse" >> /etc/apt/sources.list

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
        && apt-get update -y \
        && apt-get install -y --no-install-recommends software-properties-common apt-utils \
        && add-apt-repository -y -s universe \
        && apt-get update                 \
        && apt-get upgrade -y             \
        && apt-get install -y --no-install-recommends \
        avr-libc \
        build-essential \
        ca-certificates-java \
        cabal-install \
        cargo \
        clang \
        clang-tools \
        cmake \
        diffutils \
        docker-compose \
        docker.io \
        elfutils \
        ffmpeg \
        flac \
        gcovr \
        ghc \
        git \
        golang \
        haskell-stack \
        ksh \
        liballegro5-dev \
        liballegro-ttf5-dev \
        liballegro-image5-dev \
        libboost1.74-all-dev \
        libc-bin \
        libc-dev-bin \
        libc-devtools \
        libc6 \
        libc6-dbg \
        libc6-prof \
        libcsfml-dev \
        libcsfml-doc \
        libcunit1 \
        libcunit1-dev \
        libelf-dev \
        libfreetype-dev \
        libgmp-dev \
        libgmp10 \
        libgmp10-doc \
        libgmp3-dev \
        libgmpxx4ldbl \
        libgudev-1.0-dev \
        libirrlicht-dev \
        libirrlicht1.8 \
        libjpeg-turbo8-dev \
        libncurses-dev \
        libopenal-dev \
        libsdl2-dev \
        libsdl2-ttf-dev \
        libsdl2-mixer-dev \
        libsdl2-image-dev \
        libsdl2-gfx-dev \
        libsfml-dev \
        libsfml-doc \
        libuuid1 \
        libvirt-dev \
        libvorbis-dev \
        libx11-doc \
        libx11-xcb-dev \
        libxcb-image0 \
        libxcb-image0-dev \
        libxcb-util-dev \
        libxcb-util0-dev \
        libxcb-util1 \
        libxcursor-dev \
        libxext-dev \
        libxext-doc \
        libxi-dev \
        libxinerama-dev \
        libxrandr-dev \
        locales \
        ltrace \
        liblua5.4-dev \
        lua5.4 \
        luajit \
        nasm \
        ncurses-base \
        net-tools \
        npm \
        nodejs \
        openjdk-21-jdk \
        openjdk-21-jre \
        patch \
        php-bcmath \
        php-dev \
        php-gd \
        php-mbstring \
        php-mysql \
        php-phar-io-version \
        php-php-gettext \
        php-tokenizer \
        python3 \
        python3-pycryptodome \
        python3-dev \
        python3-numpy \
        python3-pip \
        python3-pyte \
        python3-requests \
        python3-yaml \
        python3-pandas \
        python3-matplotlib \
        python3-seaborn \
        jupyter-notebook \
        qt6-base-dev \
        qt6-base-dev-tools \
        qtbase5-dev \
        rlwrap \
        ruby \
        rustc \
        strace \
        sudo \
        systemd-dev \
        tar \
        tcpdump \
        tcsh \
        tmux \
        tree \
        unzip \
        uuid-dev \
        valgrind \
        vim \
        x264 \
        zip \
        zsh \
        curl \
        bsdextrautils \
        && apt-get clean -y \
        && rm -rf /var/lib/apt/lists/* \
        && rm -rf /usr/share/doc/*

RUN localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && npm install -g bun \
    && stack upgrade --force-download

RUN cd /tmp \
    && curl -sSL "https://github.com/Snaipe/Criterion/releases/download/v2.4.2/criterion-2.4.2-linux-x86_64.tar.xz" -o /tmp/criterion.tar.xz \
    && tar xf criterion.tar.xz \
    && cp -r /tmp/criterion-2.4.2/* /usr/local/ \
    && echo "/usr/local/lib" > /etc/ld.so.conf.d/usr-local.conf \
    && ldconfig \
    && rm -rf /tmp/* \
    && chmod 1777 /tmp

ENV LANG=en_US.utf8 LANGUAGE=en_US:en LC_ALL=en_US.utf8 PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

WORKDIR /usr/app
