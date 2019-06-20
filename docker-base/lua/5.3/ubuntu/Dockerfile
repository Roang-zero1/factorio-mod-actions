FROM ubuntu:18.04

LABEL "repository"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "homepage"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "maintainer"="Roang_zero1 <lucas@brandstaetter.tech>"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN set -ex \
    \
    && apt-get update \
    && apt-get install --no-install-recommends -y \
        lua5.3 \
    && ln -s /usr/bin/lua5.3 /usr/bin/lua \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

CMD ["lua"]
