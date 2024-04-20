# Local Values
# https://www.terraform.io/language/values/locals

locals {
  global   = data.terraform_remote_state.global.outputs
  regional = data.terraform_remote_state.regional.outputs
}
