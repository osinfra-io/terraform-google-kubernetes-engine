# Output Values
# https://www.terraform.io/language/values/outputs

output "container_cluster_ca_certificate" {
  value = module.test.container_cluster_ca_certificate
}

output "container_cluster_endpoint" {
  value = module.test.container_cluster_endpoint
}

output "container_cluster_name" {
  value = module.test.container_cluster_name
}

output "kms_key_ring_cluster_database_encryption_name" {
  value = module.test.kms_key_ring_cluster_database_encryption_name
}

output "kms_crypto_key_cluster_database_encryption_name" {
  value = module.test.kms_crypto_key_cluster_database_encryption_name
}

output "project_id" {
  value = module.test.project_id
}

output "service_account_gke_operations_email" {
  value = module.test.service_account_gke_operations_email
}
