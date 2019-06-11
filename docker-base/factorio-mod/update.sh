#!/bin/bash
set -eo pipefail


cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"
versions=( */ )
for version in "${versions[@]%/}" ; do
  for os in alpine ; do
    image=roangzero1/factorio-mod:${version}-${os}
    echo building $image ...
    docker build -q -t ${image} ${version}/${os}
    docker run --rm ${image} luacheck -v
  done
done
