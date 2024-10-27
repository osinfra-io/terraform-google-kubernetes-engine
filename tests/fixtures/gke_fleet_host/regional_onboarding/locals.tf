# Local Values
# https://www.terraform.io/language/values/locals

locals {
  main = data.terraform_remote_state.main.outputs
}
