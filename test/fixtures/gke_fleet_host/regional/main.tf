module "test_gke_fleet_host" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test
  # source = "git@github.com:osinfra-io/terraform-google-kubernetes-engine//regional?ref=v0.0.0"

  source = "../../../../regional"

  cost_center = "x000"

  cluster_autoscaling = {
    enabled = true
  }

  cluster_prefix               = "fleet-host"
  cluster_secondary_range_name = "fleet-host-k8s-pods-${var.region}"
  enable_deletion_protection   = false
  enable_gke_hub_host          = true

  # gke_hub_memberships = {
  #   "fleet-service-us-east4" = {
  #     cluster_id = "projects/test-gke-fleet-service-tf3e-sb/locations/us-east4/clusters/fleet-service-us-east4"
  #   }
  # }

  labels = {
    env    = "sb"
    region = var.region
    team   = "kitchen"
  }

  network = "kitchen-vpc"

  node_pools = {
    standard-pool = {
      machine_type = "g1-small"
    }
  }

  master_ipv4_cidr_block        = "10.61.224.0/28"
  project_id                    = "test-gke-fleet-host-tf64-sb"
  region                        = var.region
  services_secondary_range_name = "fleet-host-k8s-services-${var.region}"
  subnet                        = "fleet-host-${var.region}"
  vpc_host_project_id           = var.vpc_host_project_id
}
