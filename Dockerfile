FROM fedora:28
LABEL maintainer="Thomas Dufour <thomas.dufour@epitech.eu>"

RUN dnf -y install dnf-plugins-core &&      \
        dnf -y copr enable @dotnet-sig/dotnet \
        && dnf -y install                   \
        CUnit-devel.x86_64                  \
        SDL-devel.x86_64                    \
        SDL-static.x86_64                   \
        SDL2                                \
        SDL2-devel                          \
        SDL2-devel.x86_64                   \
        SDL2-static.x86_64                  \
        SDL2_ttf.x86_64                     \
        SDL2_ttf-devel.x86_64               \
        SDL2_image.x86_64                   \
        SDL2_image-devel.x86_64             \
        SFML.x86_64                         \
        SFML-devel.x86_64                   \
        autoconf                            \
        automake                            \
        boost                               \
        boost-devel.x86_64                  \
        boost-graph                         \
        boost-math                          \
        ca-certificates.noarch              \
        clang.x86_64                        \
        cmake.x86_64                        \
        curl.x86_64                         \
        dotnet-sdk-2.1                      \
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
        golang                              \
        gradle                              \
        java-1.8.0-openjdk                  \
        java-1.8.0-openjdk-devel            \
        ksh.x86_64                          \
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
        ncurses                             \
        ncurses-devel                       \
        ncurses-devel.x86_64                \
        ncurses-libs                        \
        ncurses.x86_64                      \
        net-tools                           \
        net-tools.x86_64                    \
        nc                                  \
        nodejs                              \
        ocaml                               \
        ocaml-camlp4.x86_64                 \
        ocaml.x86_64                        \
        openal-soft-devel.x86_64            \
    	openssl-devel                       \
        patch                               \
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
        procps-ng.x86_64                    \
        python2-numpy.x86_64                \
        python2-virtualenv                  \
        python2-virtualenv-api              \
        python3-curses_ex.x86_64            \
        python3-numpy.x86_64                \
        python3-virtualenv                  \
        python3-virtualenv-api              \
        python3.x86_64                      \
    	qt5                                 \
        qt5-devel                           \
        rlwrap.x86_64                       \
        ruby                                \
        ruby.x86_64                         \
        strace.x86_64                       \
        sudo.x86_64                         \
        systemd-devel                       \
        tar.x86_64                          \
        tcsh.x86_64                         \
        tmux.x86_64                         \
        tree.x86_64                         \
        unzip.x86_64                        \
        valgrind                            \
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
    && dnf -y update vim-minimal            \
    && dnf -y install vim                   \
    && dnf clean all -y                     \
    && pip3 install --upgrade pip	    \
    && pip3 install -Iv pexpect==4.0.1 pyrser==0.2.0 cnorm==4.0.5 gcovr==4.1 conan==1.9.0 pycrypto==2.6.1 requests==2.19.1

RUN cd /tmp \
    && git clone https://github.com/selectel/pyte.git \
    && cd pyte \
    && git checkout 358dea5b9ea11eeab6c6ed8fb73c220550e17e26 \
    && python3 setup.py install \
    && cd \
    && rm -rf /tmp/pyte \
    && cd /tmp && git clone --branch v2.3.2 https://github.com/Snaipe/Criterion \
    && cd Criterion \
    && mkdir build \
    && cd build \
    && cmake -DCMAKE_INSTALL_PREFIX=/usr .. \
    && cmake --build . \
    && make install \
    && ldconfig \
    && cd \
    && rm -rf /tmp/Criterion \
    && cd /tmp && git clone https://github.com/runkit7/runkit7.git \
    && cd runkit7 \
    && git checkout 7ddbbb0d4784751a55eac0f4f425fbc2e1d249f6 \
    && phpize && ./configure && make && make install \
    && cd \
    && rm -rf /tmp/runkit7 \
    && cd /tmp \
    && curl -LsS "https://github.com/commercialhaskell/stack/releases/download/v1.9.1/stack-1.9.1-linux-x86_64-static.tar.gz" | tar xzv \
	&& cp stack-1.9.1-linux-x86_64-static/stack /usr/local/bin/ \
    && chmod 0755 /usr/local/bin/stack \
    && curl -sSL "https://github.com/sbt/sbt/releases/download/v1.0.4/sbt-1.0.4.tgz" | tar xz \
    && mv /tmp/sbt /usr/local/share \
    && ln -s '/usr/local/share/sbt/bin/sbt' '/usr/local/bin' \
    && curl -sSL https://raw.githubusercontent.com/ocaml/opam/2.0.0-beta6/shell/opam_installer.sh | sh -s /usr/local/bin


ENV LANG=en_US.utf8 LANGUAGE=en_US:en LC_ALL=en_US.utf8

COPY fs /

RUN cd /tmp \
    && bash build_csfml.sh \
    && rm -rf /tmp/* \
    && chmod 1777 /tmp
