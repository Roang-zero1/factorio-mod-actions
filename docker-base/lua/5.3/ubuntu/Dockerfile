FROM ubuntu:18.04

LABEL "repository"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "homepage"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "maintainer"="Roang_zero1 <lucas@brandstaetter.tech>"

ENV LUA_VERSION=5.3.5

RUN set -ex \
    \
    && apt-get update \
    && apt-get install --no-install-recommends -y \
        libreadline-dev \
        ca-certificates \
        openssl \
        make \
        gcc \
        libc-dev \
        wget \
    \
    && wget -c https://www.lua.org/ftp/lua-${LUA_VERSION}.tar.gz \
        -O - | tar -xzf - \
    \
    && cd lua-${LUA_VERSION} \
    && make -j"$(nproc)" linux \
    && make install \
    && cd .. \
    && rm -rf lua-${LUA_VERSION} \
    \
    && apt-get remove -y --purge \
        ca-certificates \
        openssl \
        make \
        gcc \
        libc-dev \
        wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

CMD ["lua"]
