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
  labels                       = local.labels
  network                      = "mock-network"
  node_location                = var.node_location
  node_pools                   = var.node_pools
  master_ipv4_cidr_block       = var.master_ipv4_cidr_block
  project                      = var.project

  resource_labels = merge(local.labels, {
    region = var.region
  })

  region                        = var.region
  services_secondary_range_name = "mock-secondary-services"
  subnet                        = "mock-${var.region}-${var.zone}"
  vpc_host_project_id           = var.vpc_host_project_id
}
