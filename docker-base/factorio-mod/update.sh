#!/bin/bash
set -eo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"
versions=(*/)
for version in "${versions[@]%/}"; do
  oses=($(ls ${version}))
  for os in "${oses[@]}"; do
    image=roangzero1/factorio-mod:${version}-${os}
    echo building $image ...
    docker build -q -t ${image} ${version}/${os}
    docker run --rm ${image} luacheck -v
  done
done
