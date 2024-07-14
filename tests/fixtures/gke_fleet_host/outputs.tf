# Output Values
# https://www.terraform.io/language/values/outputs

output "container_deployer_service_accounts" {
  value = module.test.container_deployer_service_accounts
}

output "project_id" {
  value = var.project
}

output "workload_identity_service_account_emails" {
  value = module.test.workload_identity_service_account_emails
}
