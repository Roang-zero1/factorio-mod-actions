workflow "Check & Release" {
  on = "push"
  resolves = [
    "Factorio release",
    "Upload GitHub artifacts",
  ]
}

action "lint" {
  uses = "Roang-zero1/factorio-mod-luacheck@master"
  env = {
    LUACHECKRC_URL = "https://raw.githubusercontent.com/Nexela/Factorio-luacheckrc/0.17/.luacheckrc"
  }
}

action "Create Factorio mod package" {
  uses = "Roang-zero1/factorio-mod-package@master"
  needs = [
    "lint",
  ]
}

action "Tag Filter" {
  uses = "actions/bin/filter@3c0b4f0e63ea54ea5df2914b4fabf383368cd0da"
  args = "tag"
  needs = [
    "Create Factorio mod package",
  ]
}

action "Factorio release" {
  uses = "Roang-zero1/factorio-create-release-action@master"
  needs = [
    "Tag Filter"
  ]
  secrets = [
    "FACTORIO_USER",
    "FACTORIO_PASSWORD",
  ]
}

action "Create GitHub release" {
  uses = "Roang-zero1/github-create-release-action@master"
  needs = ["Tag Filter"]
  env = {
    VERSION_REGEX = "^[[:digit:]]+\\.[[:digit:]]+\\.[[:digit:]]+",
    UPDATE_EXISTING = "true",
  }
  secrets = [
    "GITHUB_TOKEN"
  ]
}


action "Upload GitHub artifacts" {
  uses = "Roang-zero1/github-upload-release-artifacts-action@master"
  args = [ "dist/"]
  needs = ["Create GitHub release"]
  secrets = [
    "GITHUB_TOKEN"
  ]
}
