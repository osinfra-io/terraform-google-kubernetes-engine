# Output Values
# https://www.terraform.io/language/values/outputs

output "istio_gateway_mci_ip" {
  description = "The IP address for the Istio Gateway multi-cluster ingress"
  value       = var.gke_fleet_host_project_id == "" ? google_compute_global_address.istio_gateway_mci[0].address : ""
}

output "istio_gateway_ssl_certificate_name" {
  description = "The name of the SSL certificate for the Istio Gateway"
  value       = var.gke_fleet_host_project_id == "" ? google_compute_managed_ssl_certificate.istio_gateway[0].name : ""
}

output "gke_fleet_host_project_number" {
  description = "The project number of the fleet host project"
  value       = var.gke_fleet_host_project_id != "" ? data.google_project.fleet_host[0].number : ""
}

output "workload_identity_service_account_emails" {
  description = "The email addresses of the service accounts for the Kubernetes namespace workload identity"
  value = {
    for k, v in google_service_account.kubernetes_workload_identity : k => v.email
  }
}
