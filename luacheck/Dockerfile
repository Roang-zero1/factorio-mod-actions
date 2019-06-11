FROM akorn/luarocks:lua5.3-alpine as base

LABEL "com.github.actions.name"="Factorio Mod luacheck"
LABEL "com.github.actions.description"="Run a Factorio mod through luacheck"
LABEL "com.github.actions.icon"="check-square"
LABEL "com.github.actions.color"="gray-dark"

LABEL "repository"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "homepage"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "maintainer"="Roang_zero1 <lucas@brandstaetter.tech>"

FROM base as luarocks

RUN apk add --no-cache git zip curl gcc musl-dev

RUN luarocks install luafilesystem
RUN luarocks install luacheck
RUN luarocks install ldoc
RUN luarocks install serpent
RUN luarocks install busted
RUN luarocks install markdown
RUN luarocks install lua-discount

FROM base

RUN apk add --no-cache jq git zip

COPY --from=luarocks /usr/local/share/lua /usr/local/share
COPY --from=luarocks /usr/local/lib/lua /usr/local/lib

ENV LUA_PATH_5_3 \
/usr/local/share/lua/5.3/?.lua;\
/usr/local/share/lua/5.3/?/init.lua;\
/usr/local/lib/lua/5.3/?.lua;\
/usr/local/lib/lua/5.3/?/init.lua;\
./?.lua

ADD clone.sh /clone.sh
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
