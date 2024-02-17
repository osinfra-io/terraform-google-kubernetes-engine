module "test" {

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

  # This code is managed by the test/test.sh script

  ### START GKE HUB MEMBERSHIPS ###

  gke_hub_memberships = {
    "fleet-member-us-east4" = {
      cluster_id = "projects/test-gke-fleet-member-tfc5-sb/locations/us-east4/clusters/fleet-member-us-east4"
    }
  }

  ### END GKE HUB MEMBERSHIPS ###

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
  project_id                    = var.project_id
  region                        = var.region
  services_secondary_range_name = "fleet-host-k8s-services-${var.region}"
  subnet                        = "fleet-host-${var.region}"
  vpc_host_project_id           = var.vpc_host_project_id
}
