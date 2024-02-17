# Output Values
# https://www.terraform.io/language/values/outputs

output "gke_fleet_host_project_id" {
  value = var.gke_fleet_host_project_id
}

output "gke_fleet_host_project_number" {
  value = module.test.gke_fleet_host_project_number
}

output "project_id" {
  value = var.project_id
}
