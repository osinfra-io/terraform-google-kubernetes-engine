# Local Values
# https://www.terraform.io/docs/language/values/locals.html

locals {
  google_service_account = var.google_service_account == "" ? google_service_account.kubernetes_namespace_admin.0.email : var.google_service_account
}
