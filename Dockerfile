FROM fedora:32
LABEL maintainer="Thomas Dufour <thomas.dufour@epitech.eu>"

RUN dnf -y install dnf-plugins-core         \
        && dnf -y copr enable petersen/stack2 \
        && dnf -y install                   \
        CUnit-devel.x86_64                  \
        SDL2                                \
        SDL2-devel.x86_64                   \
        SDL2-static.x86_64                  \
        libcaca.x86_64                      \
        libcaca-devel.x86_64                \
        SFML.x86_64                         \
        SFML-devel.x86_64                   \
        autoconf                            \
        automake                            \
        boost                               \
        boost-devel.x86_64                  \
        boost-graph                         \
        boost-math                          \
        boost-static.x86_64                 \
        ca-certificates.noarch              \
        clang.x86_64                        \
        clang-analyzer                      \
        cmake.x86_64                        \
        curl.x86_64                         \
        elfutils-libelf-devel.x86_64        \
        flac-devel.x86_64                   \
        freetype-devel.x86_64               \
        gcc-c++.x86_64                      \
        gcc.x86_64                          \
        gdb.x86_64                          \
        git                                 \
        glibc-devel.x86_64                  \
        glibc-locale-source.x86_64          \
        glibc.x86_64                        \
        gmp-devel.x86_64                    \
        java-latest-openjdk                 \
        java-latest-openjdk-devel           \
        ksh.x86_64                          \
        langpacks-en                        \
        libX11-devel.x86_64                 \
        libXext-devel.x86_64                \
        libgudev-devel                      \
        libjpeg-turbo-devel.x86_64          \
        libtsan                             \
        libvorbis-devel.x86_64              \
        llvm.x86_64                         \
        llvm-devel.x86_64                   \
        ltrace.x86_64                       \
        make.x86_64                         \
        maven                               \
        nasm.x86_64                         \
        ncurses-devel.x86_64                \
        ncurses-libs                        \
        ncurses.x86_64                      \
        net-tools.x86_64                    \
        nc                                  \
        openal-soft-devel.x86_64            \
        openssl-devel                       \
        patch                               \
        procps-ng.x86_64                    \
        python3-virtualenv                  \
        python3-virtualenv-api              \
        python3.x86_64                      \
        python3-devel.x86_64                \
        qt5                                 \
        qt5-devel                           \
        rlwrap.x86_64                       \
        strace.x86_64                       \
        sudo.x86_64                         \
        systemd-devel                       \
        tar.x86_64                          \
        tcsh.x86_64                         \
        tmux.x86_64                         \
        tree.x86_64                         \
        unzip.x86_64                        \
        valgrind.x86_64                     \
        wget.x86_64                         \
        which.x86_64                        \
        xcb-util-image-devel.x86_64         \
        xcb-util-image.x86_64               \
        xz.x86_64                           \
        zip.x86_64                          \
        zsh.x86_64                          \
        gtest.x86_64                        \
        gtest-devel.x86_64                  \
        irrlicht.x86_64                     \
        irrlicht-devel.x86_64               \
        aalib                               \
    && dnf -y update vim-minimal            \
    && dnf -y install vim                   \
    && dnf clean all -y

RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc \
        && wget -q -O /etc/yum.repos.d/microsoft-prod.repo https://packages.microsoft.com/config/fedora/32/prod.repo \
        && dnf -y copr enable petersen/stack2 \
        && dnf -y install                   \
        cargo                               \
        dotnet-sdk-3.1                      \
        ghc                                 \
        golang                              \
        nodejs                              \
        php.x86_64                          \
        php-devel.x86_64                    \
        php-bcmath.x86_64                   \
        php-cli.x86_64                      \
        php-devel.x86_64                    \
        php-gd.x86_64                       \
        php-mbstring.x86_64                 \
        php-mysqlnd.x86_64                  \
        php-pdo.x86_64                      \
        php-pear.noarch                     \
        php-json.x86_64                     \
        php-pdo.x86_64                      \
        php-xml.x86_64                      \
        php-gettext-gettext.noarch          \
        php-phar-io-version.noarch          \
        php-theseer-tokenizer.noarch        \
        rust.x86_64                         \
        stack.x86_64                        \
    && dnf clean all -y

RUN python3 -m pip install --upgrade pip	    \
    && python3 -m pip install -Iv gcovr==4.2 conan==1.27.1 pycrypto==2.6.1 requests==2.24.0 pyte==0.8.0

RUN localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && cd /tmp \
    && rpm -ivh https://github.com/samber/criterion-rpm-package/releases/download/2.3.3/libcriterion-devel-2.3.3-2.el7.x86_64.rpm \
    && cd /tmp \
    && curl -sSL "https://github.com/sbt/sbt/releases/download/v1.3.13/sbt-1.3.13.tgz" | tar xz \
    && mv /tmp/sbt /usr/local/share \
    && ln -s '/usr/local/share/sbt/bin/sbt' '/usr/local/bin' \
    && wget https://downloads.gradle-dn.com/distributions/gradle-6.5.1-bin.zip \
    && mkdir /opt/gradle && unzip -d /opt/gradle gradle-6.5.1-bin.zip && rm -f gradle-6.5.1-bin.zip

ENV LANG=en_US.utf8 LANGUAGE=en_US:en LC_ALL=en_US.utf8

COPY fs /

RUN cd /tmp \
    && bash build_csfml.sh \
    && rm -rf /tmp/* \
    && chmod 1777 /tmp
