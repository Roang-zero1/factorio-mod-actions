#!/bin/bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"
base="$(dirname "$(readlink -f "$BASH_SOURCE")")"

reposiroties=(
  "lua:lua -v"
  'luarocks:luarocks'
  'factorio-mod:luacheck -v'
)

for reposiroty_config in "${reposiroties[@]}"; do
  reposiroty=${reposiroty_config%%:*}
  echo "Building images of ${reposiroty}"
  cd ${reposiroty}
  versions=(*/)
  for version in "${versions[@]%/}"; do
    oses=($(ls ${version}))
    for os in "${oses[@]}"; do
      image=roangzero1/${reposiroty}:${version}-${os}
      echo "building $image ..."
      docker build -q -t ${image} ${version}/${os}
      docker run --rm ${image} ${reposiroty_config#*:}
    done
  done
  cd ${base}
done
