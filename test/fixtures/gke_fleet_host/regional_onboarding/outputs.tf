output "project_id" {
  value = "test-gke-fleet-host-tf64-sb"
}

output "workload_identity_service_account_emails" {
  value = {
    for k, s in module.test.workload_identity_service_account_emails : k => s
  }
}
