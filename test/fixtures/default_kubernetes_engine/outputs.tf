# Output Values
# https://www.terraform.io/language/values/outputs

output "cluster_name" {
  value = module.regional.container_cluster_name
}

output "service_account_gke_operations_email" {
  value = module.regional.service_account_gke_operations_email
}

output "kms_key_ring_cluster_database_encryption_name" {
  value = module.regional.kms_key_ring_cluster_database_encryption_name
}

output "kms_crypto_key_cluster_database_encryption_name" {
  value = module.regional.kms_crypto_key_cluster_database_encryption_name
}

output "project_id" {
  value = var.project_id
}
