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

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test
  # source = "git@github.com:osinfra-io/terraform-google-kubernetes-engine//regional?ref=v0.0.0"

  source = "../../../../regional"


  cluster_autoscaling = {
    enabled = true
  }

  cluster_prefix               = "fleet-host"
  cluster_secondary_range_name = "k8s-secondary-pods"
  enable_deletion_protection   = false
  enable_gke_hub_host          = true

  gke_hub_memberships = var.gke_hub_memberships

  labels = {
    cost-center = "x000"
    env         = "sb"
    region      = var.region
    repository  = "terraform-google-kubernetes-engine"
    team        = "kitchen"
  }

  network       = "terraform-test-vpc"
  node_location = "${var.region}-b"

  node_pools = {
    standard-pool = {
      machine_type = "g1-small"
    }
  }

  master_ipv4_cidr_block = "10.63.240.48/28"
  project                = var.project

  resource_labels = {
    env        = "sb"
    region     = var.region
    repository = "terraform-google-kubernetes-engine"
    team       = "kitchen"
  }

  region                        = var.region
  services_secondary_range_name = "k8s-secondary-services"
  subnet                        = "fleet-host-${var.region}-b"
  vpc_host_project_id           = var.vpc_host_project_id
}
