#!/bin/bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"
base="$(dirname "$(readlink -f "$BASH_SOURCE")")"

repositories=(
  "lua:lua -v"
  'luarocks:luarocks'
  'factorio-mod:luacheck -v'
)

for repository_config in "${repositories[@]}"; do
  repository=${repository_config%%:*}
  echo "Building images of ${repository}"
  cd ${repository}
  versions=(*/)
  for version in "${versions[@]%/}"; do
    oses=($(ls ${version}))
    for os in "${oses[@]}"; do
      image=roangzero1/${repository}:${version}-${os}
      echo "building $image ..."
      docker build -q -t ${image} ${version}/${os}
      docker run --rm ${image} ${repository_config#*:}
    done
  done
  cd ${base}
done
