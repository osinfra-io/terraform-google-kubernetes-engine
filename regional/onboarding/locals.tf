# Local Values
# https://www.terraform.io/docs/language/values/locals.html

locals {
  google_service_account = var.google_service_account == "" ? data.google_service_account.namespace_admin.0.email : var.google_service_account
}
