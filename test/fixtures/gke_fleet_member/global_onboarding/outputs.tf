output "kubernetes_namespace_admin_key" {
  value     = module.test.kubernetes_namespace_admin_key
  sensitive = true
}

output "workload_identity_service_account_emails" {
  value = {
    for k, s in module.test.workload_identity_service_account_emails : k => s
  }
}
