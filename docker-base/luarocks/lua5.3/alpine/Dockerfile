FROM docker.pkg.github.com/roang-zero1/factorio-mod-actions/lua:5.3-alpine

LABEL "repository"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "homepage"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "maintainer"="Roang_zero1 <lucas@brandstaetter.tech>"

ENV LUAROCKS_VERSION=3.1.2

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3003
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
    && ( \
      cd luarocks-${LUAROCKS_VERSION}; \
      ./configure --with-lua=/usr/local \
      && make build \
      && make install \
    ) \
    && rm -rf luarocks-${LUAROCKS_VERSION} \
    \
    && apk del .build-deps

CMD ["luarocks"]
