# Output Values
# https://www.terraform.io/language/values/outputs

output "cluster_ca_certificate" {
  value     = module.test_kubernetes_engine.container_cluster_ca_certificate
  sensitive = true
}

output "cluster_endpoint" {
  value = module.test_kubernetes_engine.container_cluster_endpoint
}

output "cluster_name" {
  value = module.test_kubernetes_engine.container_cluster_name
}

output "service_account_gke_operations_email" {
  value = module.test_kubernetes_engine.service_account_gke_operations_email
}

output "kms_key_ring_cluster_database_encryption_name" {
  value = module.test_kubernetes_engine.kms_key_ring_cluster_database_encryption_name
}

output "kms_crypto_key_cluster_database_encryption_name" {
  value = module.test_kubernetes_engine.kms_crypto_key_cluster_database_encryption_name
}

output "kubernetes_namespace_admin_key" {
  value     = module.test_onboarding.kubernetes_namespace_admin_key
  sensitive = true
}

output "project_id" {
  value = var.project_id
}

output "workload_identity_service_account_emails" {
  value = {
    for k, s in module.test_onboarding.workload_identity_service_account_emails : k => s
  }
}
