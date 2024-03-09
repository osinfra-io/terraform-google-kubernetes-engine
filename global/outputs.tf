# Output Values
# https://www.terraform.io/language/values/outputs

output "gke_fleet_host_project_number" {
  description = "The project number of the fleet host project"
  value       = var.gke_fleet_host_project_id != "" ? data.google_project.fleet_host[0].number : ""
}

output "workload_identity_service_account_emails" {
  value = {
    for k, s in google_service_account.kubernetes_workload_identity : k => s.email
  }
}
