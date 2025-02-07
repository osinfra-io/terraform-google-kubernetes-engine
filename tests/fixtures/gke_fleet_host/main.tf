# Required Providers
# https://developer.hashicorp.com/terraform/language/providers/requirements

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

module "test" {
  source = "../../../"

  namespaces                 = var.namespaces
  project                    = var.project
  shared_vpc_host_project_id = var.shared_vpc_host_project_id
}
