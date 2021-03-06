#!/bin/bash
set -euo pipefail

DOCKER_BASE=$GITHUB_WORKSPACE/docker-base
GITHUB_REPOSITORY_LOWER=$(echo $GITHUB_REPOSITORY | tr '[:upper:]' '[:lower:]')

repositories=(
  "lua:lua -v"
  'luarocks:luarocks'
  'factorio-mod:luacheck -v'
)

CONTAINERS=()

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
      docker build -q -t ${image} -t "docker.pkg.github.com/$GITHUB_REPOSITORY_LOWER/${repository}:${version}-${os}" ${version}/${os}
      docker run --rm ${image} ${repository_config#*:} >/dev/null
      CONTAINERS+=("docker.pkg.github.com/$GITHUB_REPOSITORY_LOWER/${repository}:${version}-${os}")
    done
  done
done

echo "Currently available images:"
docker image ls

if [ $PUBLISH_IMAGE == "true" ]; then
  echo "Publishing images to GPR"
  docker login docker.pkg.github.com -u ${GITHUB_ACTOR} -p ${GITHUB_TOKEN}
  for container in "${CONTAINERS[@]}"; do
    repository=${repository_config%%:*}
    docker push $container
  done
else
  echo "Not publishing images"
fi
