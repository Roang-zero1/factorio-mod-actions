#!/bin/bash
set -eo pipefail


cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"
base="$(dirname "$(readlink -f "$BASH_SOURCE")")"

images=( */ )

for image in "${images[@]%/}"; do
  cd ${image}
  versions=( */ )
  for version in "${versions[@]%/}" ; do
    oses=( $(ls ${version}) )
    for os in "${oses[@]}" ; do
      image=roangzero1/lua:${version}-${os}
      echo building $image ...
      docker build -q -t ${image} ${version}/${os}
      docker run --rm ${image} lua -v
    done
  done
  cd ${base}
done
