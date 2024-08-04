# Output Values
# https://www.terraform.io/language/values/outputs

output "container_deployer_service_accounts" {
  value = module.test.container_deployer_service_accounts
}

output "gke_fleet_host_project_number" {
  value = module.test.gke_fleet_host_project_number
}

output "workload_identity_service_account_emails" {
  value = module.test.workload_identity_service_account_emails
}
