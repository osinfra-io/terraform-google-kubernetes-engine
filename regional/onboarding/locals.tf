# Local Values
# https://www.terraform.io/docs/language/values/locals.html

locals {
  namespace_admin_service_accounts = {
    for k, v in var.namespaces : "${k}:${v.google_service_account}" => {
      namespace       = k,
      service_account = v.google_service_account
    }
  }
}
