# syntax=docker/dockerfile:1
FROM ubuntu:noble
LABEL maintainer="Alexandre Vanhecke <alexandre1.vanhecke@epitech.eu>"

# Keep apt caches/lists out of the image layers (handled by BuildKit cache mounts below)
# and skip docs/man/info on every subsequent install (saves space across all layers).
RUN rm -f /etc/apt/apt.conf.d/docker-clean \
        && printf 'path-exclude /usr/share/doc/*\npath-include /usr/share/doc/*/copyright\npath-exclude /usr/share/man/*\npath-exclude /usr/share/info/*\npath-exclude /usr/share/groff/*\n' \
           > /etc/dpkg/dpkg.cfg.d/01-nodoc

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
        echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
        && apt-get update -y \
        && apt-get install -y --no-install-recommends software-properties-common apt-utils wget \
        && add-apt-repository -y -s universe \
        && add-apt-repository -y -s ppa:epitech/ppa \
        && wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/trusted.gpg.d/llvm.asc \
        && echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/llvm.asc] https://apt.llvm.org/noble/ llvm-toolchain-noble-20 main" | tee /etc/apt/sources.list.d/llvm.list \
        && apt-get update \
        && apt-get upgrade -y \
        && apt-get install -y \
        clang-20 \
        python3-clang-20 \
        locales

# epitech-full split into separate layers for cache granularity (cheap re-pulls on a bump).
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get install -y --no-install-recommends epitech-cpool
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get install -y --no-install-recommends epitech-premsc
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get install -y --no-install-recommends epitech-tek1
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get install -y --no-install-recommends epitech-tek2
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get install -y --no-install-recommends epitech-web

RUN localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && stack upgrade --force-download \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-20 100 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-20 100 \
    && update-alternatives --install /usr/bin/scan-build scan-build /usr/bin/scan-build-20 100 \
    && update-alternatives --install /usr/bin/llvm-cov llvm-cov /usr/bin/llvm-cov-20 900

# Layer to update banana (and epiclang) only, check version at https://launchpad.net/~epitech/+archive/ubuntu/ppa
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get update -y \
    && apt-get install -y --no-install-recommends banana-coding-style-checker=20260504094343 epiclang=20260407090709

ENV LANG=en_US.utf8 LANGUAGE=en_US:en LC_ALL=en_US.utf8 PKG_CONFIG_PATH=/usr/local/lib/pkgconfig CC=clang CXX=clang++ JUPYTER_DATA_DIR=/tmp JUPYTER_RUNTIME_DIR=/tmp MPLCONFIGDIR=/tmp

WORKDIR /usr/app
