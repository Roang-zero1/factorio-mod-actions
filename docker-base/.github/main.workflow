workflow "Check & Release" {
  on = "push"
  resolves = [
    "lint",
    "shfmt",
  ]
}

action "lint" {
  uses = "docker://cdssnc/docker-lint-github-action"
  args = "--ignore DL3007 --ignore DL3008 --ignore DL3018"
}

action "shfmt" {
  uses = "roang-zero1/actions/shfmt@master"
  secrets = ["GITHUB_TOKEN"]
  env = {
    SHFMT_ARGS="-i 2 -ci",
  }
}
