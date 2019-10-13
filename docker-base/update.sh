#!/bin/bash
set -euo pipefail

DOCKER_BASE=$GITHUB_WORKSPACE/docker-base
GITHUB_REPOSITORY_LOWER=$(echo $GITHUB_REPOSITORY | tr '[:upper:]' '[:lower:]')

repositories=(
  "lua:lua -v"
  'luarocks:luarocks'
  'factorio-mod:luacheck -v'
)

for repository_config in "${repositories[@]}"; do
  repository=${repository_config%%:*}
  echo "Building images of ${repository}"
  cd $DOCKER_BASE/${repository}
  versions=(*/)
  for version in "${versions[@]%/}"; do
    oses=($(ls ${version}))
    for os in "${oses[@]}"; do
      image=roangzero1/${repository}:${version}-${os}
      echo "building $image ..."
      docker build -q -t ${image} -t docker.pkg.github.com/$GITHUB_REPOSITORY_LOWER/$repository:latest ${version}/${os}
      docker run --rm ${image} ${repository_config#*:} >/dev/null
    done
  done
done

echo "Currently available images:"
docker image ls

if [ $PUBLISH_IMAGE -eq 'true ']; then
  echo "Publishing images to GPR"
  docker login docker.pkg.github.com -u ${GITHUB_ACTOR} -p ${GITHUB_TOKEN}
  for repository_config in "${repositories[@]}"; do
    repository=${repository_config%%:*}
    docker push docker.pkg.github.com/$GITHUB_REPOSITORY_LOWER/$repository:latest
  done
else
  echo "Not publishing images"
fi
