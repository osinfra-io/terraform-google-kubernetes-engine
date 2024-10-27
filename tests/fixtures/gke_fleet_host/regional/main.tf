# Required Providers
# https://developer.hashicorp.com/terraform/language/providers/requirements

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    google-beta = {
      source = "hashicorp/google-beta"
    }
  }
}

module "test" {
  source = "../../../../regional"

  cluster_prefix               = "mock"
  cluster_secondary_range_name = "mock-secondary-pods"
  enable_deletion_protection   = false
  enable_gke_hub_host          = var.enable_gke_hub_host
  gke_hub_memberships          = var.gke_hub_memberships
  helpers_cost_center          = var.helpers_cost_center
  helpers_data_classification  = var.helpers_data_classification
  helpers_email                = var.helpers_email
  helpers_repository           = var.helpers_repository
  helpers_team                 = var.helpers_team

  labels = {
    mock-key = "mock-value"
  }

  network                = "mock-network"
  node_pools             = var.node_pools
  master_ipv4_cidr_block = var.master_ipv4_cidr_block
  project                = var.project

  resource_labels = {
    mock-key = "mock-value"
  }

  services_secondary_range_name = "mock-secondary-services"
  subnet                        = "mock-subnet"
  vpc_host_project_id           = var.vpc_host_project_id
}
