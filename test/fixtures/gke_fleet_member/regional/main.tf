module "test" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test
  # source = "git@github.com:osinfra-io/terraform-google-kubernetes-engine//regional?ref=v0.0.0"

  source = "../../../../regional"


  cluster_autoscaling = {
    enabled = true
  }

  cluster_prefix               = "fleet-member"
  cluster_secondary_range_name = "k8s-secondary-pods"
  enable_deletion_protection   = false

  labels = {
    cost-center = "x000"
    env         = "sb"
    region      = var.region
    repository  = "terraform-google-kubernetes-engine"
    team        = "kitchen"
  }

  network                = "kitchen-vpc"
  master_ipv4_cidr_block = "10.63.240.16/28"
  project                = var.project
  region                 = var.region

  resource_labels = {
    env        = "sb"
    region     = var.region
    repository = "terraform-google-kubernetes-engine"
    team       = "kitchen"
  }

  services_secondary_range_name = "k8s-secondary-services"
  subnet                        = "fleet-member-${var.region}"
  vpc_host_project_id           = var.vpc_host_project_id
}

resource "google_artifact_registry_repository_iam_member" "docker_virtual_readers" {
  location   = "us"
  project    = var.vpc_host_project_id
  repository = "projects/test-default-tf75-sb/locations/us/repositories/test-virtual"
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${module.test.service_account_gke_operations_email}"
}
