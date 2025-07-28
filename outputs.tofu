# Output Values
# https://opentofu.org/docs/language/values/outputs

output "container_deployer_service_accounts" {
  description = "The service accounts for the container deployer"
  value       = local.container_deployer_service_accounts
}

output "gke_fleet_host_project_number" {
  description = "The project number of the fleet host project"
  value       = var.gke_fleet_host_project_id != "" ? data.google_project.this.number : ""
}

output "workload_identity_service_account_emails" {
  description = "The email addresses of the service accounts for the Kubernetes namespace workload identity"
  value = {
    for k, v in google_service_account.kubernetes_workload_identity : k => v.email
  }
}
