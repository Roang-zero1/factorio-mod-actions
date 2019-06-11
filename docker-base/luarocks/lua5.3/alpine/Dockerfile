
FROM roangzero1/lua:5.3-alpine

LABEL "repository"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "homepage"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "maintainer"="Roang_zero1 <lucas@brandstaetter.tech>"


ENV LUAROCKS_VERSION=3.1.2

RUN set -ex \
    \
    && apk add --no-cache \
        ca-certificates \
        openssl \
        curl \
        readline-dev \
    \
    && apk add --no-cache --virtual .build-deps \
        make \
        gcc \
        libc-dev \
        ncurses-dev \
    \
    && wget https://luarocks.github.io/luarocks/releases/luarocks-${LUAROCKS_VERSION}.tar.gz \
        -O - | tar -xzf - \
    \
    && cd luarocks-${LUAROCKS_VERSION} \
    && ./configure --with-lua=/usr/local \
    && make build \
    && make install \
    && cd .. \
    && rm -rf luarocks-${LUAROCKS_VERSION} \
    \
    && apk del .build-deps

CMD ["luarocks"]
