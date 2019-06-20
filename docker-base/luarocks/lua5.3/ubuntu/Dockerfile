
FROM roangzero1/lua:5.3-ubuntu

LABEL "repository"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "homepage"="https://github.com/Roang-zero1/factorio-mod-actions"
LABEL "maintainer"="Roang_zero1 <lucas@brandstaetter.tech>"


ENV LUAROCKS_VERSION=3.1.3

RUN set -ex \
  \
  && apt-get update \
  && apt-get install --no-install-recommends -y \
        ca-certificates \
        openssl \
        curl \
        unzip \
  \
  ## Build dependencies
  && apt-get install --no-install-recommends -y \
      make \
      gcc \
      libc-dev \
      ncurses-dev \
      wget \
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
  && apt-get remove -y \
      make \
      gcc \
      libc-dev \
      ncurses-dev \
      wget \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

CMD ["luarocks"]
