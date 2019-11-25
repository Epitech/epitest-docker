FROM fedora:30
LABEL maintainer="Thomas Dufour <thomas.dufour@epitech.eu>"

RUN dnf -y install dnf-plugins-core         \
        && dnf -y copr enable @dotnet-sig/dotnet \
        && dnf -y copr enable petersen/stack2 \
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
        gradle                              \
        java-openjdk                        \
        java-openjdk-devel                  \
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
        ncurses                             \
        ncurses-devel                       \
        ncurses-devel.x86_64                \
        ncurses-libs                        \
        ncurses.x86_64                      \
        net-tools                           \
        net-tools.x86_64                    \
        nc                                  \
        openal-soft-devel.x86_64            \
    	openssl-devel                       \
        patch                               \
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
        irrlicht.x86_64                     \
        irrlicht-devel.x86_64               \
    && dnf -y update vim-minimal            \
    && dnf -y install vim                   \
    && dnf clean all -y

RUN dnf -y copr enable @dotnet-sig/dotnet \
        && dnf -y copr enable petersen/stack2 \
        && dnf -y install                   \
        cargo                               \
        dotnet-sdk-2.1                      \
        ghc                                 \
        golang                              \
        nodejs                              \
        ocaml                               \
        ocaml-camlp4.x86_64                 \
        ocaml.x86_64                        \
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
        ruby                                \
        ruby.x86_64                         \
        rust                                \
        stack.x86_64                        \
    && dnf clean all -y

RUN python3 -m pip install --upgrade pip	    \
    && python3 -m pip install -Iv gcovr==4.1 conan==1.15.1 pycrypto==2.6.1 requests==2.22.0 pyte==0.8.0

RUN localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && cd /tmp \
    && rpm -ivh https://github.com/samber/criterion-rpm-package/releases/download/2.3.3/libcriterion-devel-2.3.3-2.el7.x86_64.rpm \
    && git clone https://github.com/runkit7/runkit7.git \
    && cd runkit7 \
    && git checkout 84e5b5e04af239c9d79b09be1b1dc0d0ac23b477 \
    && phpize && ./configure && make && make install \
    && cd \
    && rm -rf /tmp/runkit7 \
    && cd /tmp \
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
