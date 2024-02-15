# Output Values
# https://www.terraform.io/language/values/outputs

output "cluster_ca_certificate" {
  value     = module.test_gke_fleet_service.container_cluster_ca_certificate
  sensitive = true
}

output "cluster_endpoint" {
  value = module.test_gke_fleet_service.container_cluster_endpoint
}

output "cluster_name" {
  value = module.test_gke_fleet_service.container_cluster_name
}

output "container_cluster_id" {
  value = module.test_gke_fleet_service.container_cluster_id
}

output "service_account_gke_operations_email" {
  value = module.test_gke_fleet_service.service_account_gke_operations_email
}

output "kms_key_ring_cluster_database_encryption_name" {
  value = module.test_gke_fleet_service.kms_key_ring_cluster_database_encryption_name
}

output "kms_crypto_key_cluster_database_encryption_name" {
  value = module.test_gke_fleet_service.kms_crypto_key_cluster_database_encryption_name
}

output "project_id" {
  value = module.test_gke_fleet_service.project_id
}
