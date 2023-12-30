# Local Values
# https://www.terraform.io/language/values/locals

locals {
  setup = data.terraform_remote_state.setup.outputs
}
