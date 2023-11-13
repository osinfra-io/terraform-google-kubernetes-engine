# Output Values
# https://www.terraform.io/language/values/outputs

output "cluster_name" {
  value = module.test.cluster_name
}

output "location" {
  value = module.test.location
}

output "project_id" {
  value = var.project_id
}
