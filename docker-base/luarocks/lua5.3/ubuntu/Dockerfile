
FROM roangzero1/lua:5.3-ubuntu

LABEL "repository"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "homepage"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "maintainer"="Roang_zero1 <lucas@brandstaetter.tech>"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3003
RUN set -ex \
    \
    && apt-get update \
    && apt-get install --no-install-recommends -y \
          luarocks \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

CMD ["luarocks"]
