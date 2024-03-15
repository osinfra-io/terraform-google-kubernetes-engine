# Output Values
# https://www.terraform.io/language/values/outputs

output "istio_gateway_mci_ip" {
  value = module.test.istio_gateway_mci_ip
}

output "istio_gateway_ssl_certificate_name" {
  value = module.test.istio_gateway_ssl_certificate_name
}

output "project_id" {
  value = var.project_id
}

output "workload_identity_service_account_emails" {
  value = module.test.workload_identity_service_account_emails
}
