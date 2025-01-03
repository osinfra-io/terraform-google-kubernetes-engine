# Local Values
# https://www.terraform.io/docs/language/values/locals.html

locals {
  container_deployer_service_accounts = toset(distinct([
    for k in values(var.namespaces) : k.google_service_account
  ]))
}
