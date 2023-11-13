# Output Values
# https://www.terraform.io/language/values/outputs

output "container_cluster_ca_certificate" {
  description = "Base64 encoded public certificate that is the root of trust for the cluster"
  sensitive   = true
  value       = google_container_cluster.this.master_auth[0].cluster_ca_certificate
}

output "container_cluster_endpoint" {
  description = "The connection endpoint for the cluster"
  value       = google_container_cluster.this.endpoint
}

output "container_cluster_id" {
  description = "The unique identifier for the cluster"
  value       = google_container_cluster.this.id
}

output "container_cluster_name" {
  description = "The name of the cluster, unique within the project and location"
  value       = google_container_cluster.this.name
}

output "kms_crypto_key_cluster_database_encryption_name" {
  description = "The name of the Google Cloud KMS crypto key used to encrypt the secrets"
  value       = google_kms_crypto_key.cluster_database_encryption.name
}

output "service_account_gke_operations_email" {
  description = "The email address of the Kubernetes minimum privilege service account for the cluster"
  value       = google_service_account.gke_operations.email
}
