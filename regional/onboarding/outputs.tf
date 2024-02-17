# Output Values
# https://www.terraform.io/language/values/outputs

output "project_id" {
  description = "The project ID"
  value       = var.project_id
}

output "workload_identity_service_account_emails" {
  value = {
    for k, s in data.google_service_account.workload_identity : k => s.email
  }
}
