# GitHub Actions for Factorio Mods

This repository contains actions to test and deploy your Factorio mod with GitHub Actions.

## Deploy images

```bash
docker images --format "{{.Repository}}:{{.Tag}}" | awk '/roangzero1/ && !/none/' | tac | xargs -I {} docker push {}
```

## Acknowledgements

Files based on [akornatskyy/docker-library/](https://github.com/akornatskyy/docker-library/)
