module "test_gke_fleet_service" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test
  # source = "git@github.com:osinfra-io/terraform-google-kubernetes-engine//regional?ref=v0.0.0"

  source = "../../../../regional"

  cost_center = "x000"

  cluster_autoscaling = {
    enabled = true
  }

  cluster_prefix               = "fleet-service"
  cluster_secondary_range_name = "fleet-service-k8s-pods-${var.region}"
  enable_deletion_protection   = false

  labels = {
    env    = "sb"
    region = var.region
    team   = "kitchen"
  }

  network                       = "kitchen-vpc"
  master_ipv4_cidr_block        = "10.61.224.16/28"
  project_id                    = "test-gke-fleet-service-tf3e-sb"
  region                        = var.region
  services_secondary_range_name = "fleet-service-k8s-services-${var.region}"
  subnet                        = "fleet-service-${var.region}"
  vpc_host_project_id           = var.vpc_host_project_id
}
