FROM fedora:39
LABEL maintainer="Thomas Dufour <thomas.dufour@epitech.eu>"

RUN dnf -y upgrade \
    && dnf -y install dnf-plugins-core \
    && dnf -y --refresh install \
    --setopt=tsflags=nodocs \
    --setopt=deltarpm=false \
    CSFML \
    CSFML-devel \
    SDL2 \
    SDL2-devel \
    SDL2-static \
    SDL2_gfx \
    SDL2_gfx-devel \
    SDL2_image \
    SDL2_image-devel \
    SDL2_mixer \
    SDL2_mixer-devel \
    SDL2_ttf \
    SDL2_ttf-devel \
    SFML \
    SFML-devel \
    allegro5 \
    allegro5-devel \
    autoconf \
    automake \
    boost \
    boost-devel \
    boost-graph \
    boost-math \
    boost-static \
    ca-certificates \
    clang \
    clang-analyzer \
    cmake \
    curl \
    diffutils \
    elfutils-libelf-devel \
    gcc \
    gcc-c++ \
    gdb \
    git \
    glibc \
    glibc-devel \
    glibc-locale-source \
    gmp-devel \
    ksh \
    langpacks-en \
    libX11-devel \
    libXcursor-devel \
    libXext-devel \
    libXi-devel \
    libXinerama-devel \
    libXrandr-devel \
    libasan \
    libcaca \
    libcaca-devel \
    libconfig \
    libconfig-devel \
    libjpeg-turbo-devel \
    libtsan \
    libtsan \
    libubsan \
    llvm \
    llvm-devel \
    ltrace \
    make \
    nasm \
    nc \
    ncurses \
    ncurses-devel \
    ncurses-libs \
    net-tools \
    openal-soft-devel \
    openssl-devel \
    patch \
    procps-ng \
    python3 \
    python3-devel \
    rlwrap \
    ruby \
    strace \
    sudo \
    systemd-devel \
    tar \
    tcsh \
    tmux \
    tree \
    unzip \
    valgrind \
    vim \
    wget \
    which \
    xcb-util-image \
    xcb-util-image-devel \
    xz \
    zip \
    zsh \
    && dnf clean all -y \
    && rm -rf /var/cache/yum

# Large layer was splitted because build timeout on push to github package
RUN dnf -y --refresh install \
    --setopt=tsflags=nodocs \
    --setopt=deltarpm=false \
    bc \
    gcovr \
    ghc \
    golang \
    java-17-openjdk \
    java-17-openjdk-devel \
    libuuid libuuid-devel \
    nodejs \
    php \
    php-bcmath \
    php-cli \
    php-devel \
    php-devel \
    php-gd \
    php-gettext-gettext \
    php-mbstring \
    php-mysqlnd \
    php-pdo \
    php-pdo \
    php-pear \
    php-phar-io-version \
    php-theseer-tokenizer \
    php-xml \
    python-numpy \
    python-pycryptodomex \
    python-pyte \
    python-requests \
    rustup \
    && dnf clean all \
    && rm -rf /var/cache/yum

RUN python3 -m pip install --upgrade pip \
    && localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && rustup-init -y --default-toolchain stable

RUN cd /tmp \
    && curl -fsSL https://bun.sh/install | bash

RUN cd /tmp \
    && curl -sSL "https://github.com/Snaipe/Criterion/releases/download/v2.4.2/criterion-2.4.2-linux-x86_64.tar.xz" -o /tmp/criterion.tar.xz \
    && tar xf criterion.tar.xz \
    && cp -r /tmp/criterion-2.4.2/* /usr/local/ \
    && echo "/usr/local/lib" > /etc/ld.so.conf.d/usr-local.conf \
    && ldconfig

RUN cd /tmp \
   && curl -sSL https://get.haskellstack.org/ | sh

ENV LANG=en_US.utf8 LANGUAGE=en_US:en LC_ALL=en_US.utf8 PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

RUN cd /tmp \
    && rm -rf /tmp/* \
    && chmod 1777 /tmp

WORKDIR /usr/app
