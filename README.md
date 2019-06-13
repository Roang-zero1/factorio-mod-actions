# GitHub Actions for Factorio Mods

This repository contains actions to test and deploy your Factorio mod with GitHub Actions.

## Deploy images

```bash
docker images --format "{{.Repository}}:{{.Tag}}" | awk '/roangzero1/ && !/none/' | tac | xargs -I {} docker push {}
```

## Acknowledgements

Docker files for Lua based on [akornatskyy/docker-library/](https://github.com/akornatskyy/docker-library/)

Factorio build scripts based on:

* [Nexelas Mods](https://github.com/Nexela)
* [GitHub Action to automatically publish to the Factorio mod portal](https://github.com/shanemadden/factorio-mod-portal-publish)
