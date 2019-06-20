FROM roangzero1/luarocks:lua5.3-ubuntu as base

LABEL "repository"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "homepage"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "maintainer"="Roang_zero1 <lucas@brandstaetter.tech>"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        jq \
        git \
        zip \
        curl \
    && apt-get install --no-install-recommends -y \
        gcc \
        liblua5.3-dev \
    && luarocks install luacheck \
    && apt remove -y --purge \
        gcc \
        liblua5.3-dev \
    && apt autoremove -y --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV LUA_PATH_5_3 \
/usr/local/share/lua/5.3/?.lua;\
/usr/local/share/lua/5.3/?/init.lua;\
/usr/local/lib/lua/5.3/?.lua;\
/usr/local/lib/lua/5.3/?/init.lua;\
./?.lua

CMD [ "luacheck" ]
