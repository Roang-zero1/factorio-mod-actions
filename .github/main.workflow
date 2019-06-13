workflow "New workflow" {
  on       = "push"

  resolves = [
    "release",
    "release-github",
  ]
}

action "luacheck" {
  uses = "Roang-zero1/factorio-mod-actions/luacheck@master"

  env  = {
    LUACHECKRC_URL = "https://raw.githubusercontent.com/Nexela/Factorio-luacheckrc/0.17/.luacheckrc"
  }
}

action "package" {
  uses  = "Roang-zero1/factorio-mod-actions/package@master"

  needs = [
    "luacheck"
  ]
}

action "Tag Filter" {
  uses  = "actions/bin/filter@3c0b4f0e63ea54ea5df2914b4fabf383368cd0da"
  args  = "tag"

  needs = [
    "package"
  ]
}

action "release" {
  uses    = "Roang-zero1/factorio-mod-actions/release@master"

  needs   = [
    "Tag Filter"
  ]

  secrets = [
    "FACTORIO_USER",
    "FACTORIO_PASSWORD"
  ]
}

action "release-github" {
  uses    = "Roang-zero1/factorio-mod-actions/release-github@master"

  needs   = [
    "Tag Filter"
  ]

  secrets = [
    "GITHUB_TOKEN"
  ]
}
