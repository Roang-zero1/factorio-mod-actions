FROM alpine:3.8

LABEL "repository"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "homepage"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "maintainer"="Roang_zero1 <lucas@brandstaetter.tech>"

ENV LUA_VERSION=5.3.5

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3003
RUN set -ex \
    \
    && apk add --no-cache readline-dev \
    && apk add --no-cache --virtual .build-deps \
        ca-certificates \
        openssl \
        make \
        gcc \
        libc-dev \
    \
    && wget -c https://www.lua.org/ftp/lua-${LUA_VERSION}.tar.gz \
        -O - | tar -xzf - \
    \
    && ( \
      cd lua-${LUA_VERSION}; \
      make -j"$(nproc)" linux \
      && make install \
    ) \
    && rm -rf lua-${LUA_VERSION} \
    \
    && apk del .build-deps

CMD ["lua"]
