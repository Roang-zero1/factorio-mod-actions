FROM roangzero1/luarocks:lua5.3-alpine as base

LABEL "repository"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "homepage"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "maintainer"="Roang_zero1 <lucas@brandstaetter.tech>"

SHELL ["/bin/ash", "-o", "pipefail", "-c"]
RUN set -ex \
    \
    && apk add --no-cache \
        git \
        jq \
        zip \
        curl \
    && apk add --no-cache --virtual .build-deps \
        gcc \
        musl-dev \
    && luarocks install luacheck \
    && apk del .build-deps

ENV LUA_PATH_5_3 \
/usr/local/share/lua/5.3/?.lua;\
/usr/local/share/lua/5.3/?/init.lua;\
/usr/local/lib/lua/5.3/?.lua;\
/usr/local/lib/lua/5.3/?/init.lua;\
./?.lua

CMD [ "luacheck" ]
