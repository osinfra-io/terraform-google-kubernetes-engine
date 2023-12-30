# With Shared VPC, you designate one project as the host project, and you can attach other projects,
# called service projects, to the host project. You create networks, subnets, secondary address ranges,
# firewall rules, and other network resources in the host project. Then you share selected subnets,
# including secondary ranges, with the service projects. Components running in a service project can use
# the Shared VPC to communicate with components running in the other service projects.

# https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-shared-vpc

module "test_kubernetes_engine" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test
  # source = "git@github.com:osinfra-io/terraform-google-kubernetes-engine//regional?ref=v0.0.0"

  source = "../../../regional/infra"

  cost_center = "x000"

  cluster_autoscaling = {
    enabled = true
  }

  cluster_prefix               = "kitchen"
  cluster_secondary_range_name = "kitchen-k8s-pods-${var.region}"
  enable_deletion_protection   = false
  host_project_id              = var.host_project_id

  labels = {
    "env"    = "sb"
    "region" = var.region
    "team"   = "kitchen"
  }

  network = "kitchen-vpc"

  node_pools = {
    standard-pool = {
      machine_type = "g1-small"
    }
  }

  master_ipv4_cidr_block        = var.master_ipv4_cidr_block
  project_id                    = var.project_id
  project_number                = var.project_number
  region                        = var.region
  services_secondary_range_name = "kitchen-k8s-services-${var.region}"
  subnet                        = "kitchen-subnet-${var.region}"
}

module "test_onboarding" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test.
  # source = "github.com/osinfra-io/terraform-google-kubernetes-onboarding//global?ref=v0.0.0"

  source = "../../../global/onboarding"

  namespaces = {
    foo = {}
    bar = {}
  }

  project_id      = var.project_id
  namespace_admin = "test"
}

module "test_onboarding_service_account" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test.
  # source = "github.com/osinfra-io/terraform-google-kubernetes-onboarding//global?ref=v0.0.0"

  source = "../../../global/onboarding"

  # This test is using a service account that is not a service account that is created by the module. For example, teams
  # may want to use a service account they already use for existing workflows.

  google_service_account = "plt-lz-testing-github@ptl-lz-terraform-tf91-sb.iam.gserviceaccount.com"

  namespaces = {
    cat = {}
    dog = {}
  }

  project_id = var.project_id
}
