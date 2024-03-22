# Output Values
# https://www.terraform.io/language/values/outputs

output "container_deployer_service_accounts" {
  value = module.test.container_deployer_service_accounts
}

output "istio_gateway_mci_global_address" {
  value = module.test.istio_gateway_mci_global_address
}

output "istio_gateway_mci_ssl_certificate_name" {
  value = module.test.istio_gateway_mci_ssl_certificate_name
}

output "project_id" {
  value = var.project_id
}

output "workload_identity_service_account_emails" {
  value = module.test.workload_identity_service_account_emails
}
