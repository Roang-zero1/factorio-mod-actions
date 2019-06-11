workflow "New workflow" {
  on = "push"
  resolves=["luacheck"]
}

action "luacheck" {
  uses = "./luacheck"
  args = "Test"
}
