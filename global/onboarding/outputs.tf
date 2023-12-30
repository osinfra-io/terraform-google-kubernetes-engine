# Terraform Output Values
# https://www.terraform.io/language/values/outputs

output "kubernetes_namespace_admin_key" {
  value     = var.google_service_account == "" ? google_service_account_key.kubernetes_namespace_admin.0.private_key : null
  sensitive = true
}

output "workload_identity_service_account_emails" {
  value = {
    for k, s in google_service_account.kubernetes_workload_identity : k => s.email
  }
}
