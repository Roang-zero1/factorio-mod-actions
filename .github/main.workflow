workflow "New workflow" {
  on       = "push"

  resolves = [
    "release"
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

action "Release Filter" {
  uses  = "actions/bin/filter@3c0b4f0e63ea54ea5df2914b4fabf383368cd0da"
  args  = "branch release"

  needs = [
    "package"
  ]
}

action "release" {
  uses    = "Roang-zero1/factorio-mod-actions/release@master"

  needs   = [
    "Release Filter"
  ]

  secrets = [
    "FACTORIO_USER",
    "FACTORIO_PASSWORD"
  ]
}
