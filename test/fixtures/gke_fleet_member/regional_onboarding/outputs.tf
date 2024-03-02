output "project_id" {
  value = var.project_id
}

output "workload_identity_service_account_emails" {
  value = {
    for k, s in module.test.workload_identity_service_account_emails : k => s
  }
}
