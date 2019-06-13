FROM roangzero1/luarocks:lua5.3-alpine as base

LABEL "com.github.actions.name"="Factorio Mod luacheck"
LABEL "com.github.actions.description"="Run a Factorio mod through luacheck"
LABEL "com.github.actions.icon"="check-square"
LABEL "com.github.actions.color"="gray-dark"

LABEL "repository"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "homepage"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "maintainer"="Roang_zero1 <lucas@brandstaetter.tech>"

FROM base as luarocks

RUN apk add --no-cache git zip curl gcc musl-dev

RUN luarocks install luacheck

FROM base

RUN apk add --no-cache jq git zip curl

COPY --from=luarocks /usr/local/bin /usr/local/bin
COPY --from=luarocks /usr/local/lib/lua /usr/local/lib/lua
COPY --from=luarocks /usr/local/lib/luarocks /usr/local/lib/luarocks
COPY --from=luarocks /usr/local/share/lua /usr/local/share/lua

ENV LUA_PATH_5_3 \
/usr/local/share/lua/5.3/?.lua;\
/usr/local/share/lua/5.3/?/init.lua;\
/usr/local/lib/lua/5.3/?.lua;\
/usr/local/lib/lua/5.3/?/init.lua;\
./?.lua

CMD [ "luacheck" ]
