# Google Project Data Source
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project#google_project

data "google_project" "fleet_host" {
  count = var.gke_fleet_host_project_id != "" ? 1 : 0

  project_id = var.gke_fleet_host_project_id
}

# Local variable for conditional IAM bindings
locals {
  fleet_host_project_defined = var.gke_fleet_host_project_id != ""
  fleet_host_project_id      = try(data.google_project.fleet_host[0].number, "")
}

# This section provides an example MCS configuration involving two existing GKE clusters each in a different Shared VPC service project.
# https://cloud.google.com/kubernetes-engine/docs/how-to/msc-setup-with-shared-vpc-networks#two-service-projects-iam

# Google Project IAM Member Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam#google_project_iam_member

# Create IAM binding granting the fleet host project's GKE Hub service account the GKE Service Agent role on the service cluster's project.

resource "google_project_iam_member" "gke_hub_service_agent" {
  count = var.gke_fleet_host_project_id != "" ? 1 : 0

  member  = "serviceAccount:serviceAccount:service-${local.fleet_host_project_id}@gcp-sa-gkehub.iam.gserviceaccount.com"
  project = var.project
  role    = "roles/gkehub.serviceAgent"
}

# Create IAM binding granting the fleet host project MCS service account the MCS Service Agent role on the Shared VPC host project.

resource "google_project_iam_member" "multi_cluster_service_agent" {
  count = var.gke_fleet_host_project_id == "" ? 1 : 0

  member  = "serviceAccount:serviceAccount:service-${local.fleet_host_project_id}@gcp-sa-mcsd.iam.gserviceaccount.com"
  project = var.shared_vpc_host_project_id
  role    = "roles/multiclusterservicediscovery.serviceAgent"
}

# Create IAM binding granting each project's MCS service account the Network User role for its own project.
# Because this scenario uses workload identity federation for GKE, each project's MCS Importer GKE service
# account needs the Network User role for its own project.

# These resources needs a clusters created first, so new infrastructure builds will fail on the global run.
# As a W/A run the regional infrastructure first and then the global infrastructure.

resource "google_project_iam_member" "host_project_network_viewer" {
  count = var.gke_fleet_host_project_id != "" ? 1 : 0

  member  = "serviceAccount:${var.gke_fleet_host_project_id}.svc.id.goog[gke-mcs/gke-mcs-importer]"
  project = var.project
  role    = "roles/compute.networkViewer"
}

resource "google_project_iam_member" "service_project_network_viewer" {
  count = var.gke_fleet_host_project_id == "" ? 1 : 0

  member  = "serviceAccount:${var.project}.svc.id.goog[gke-mcs/gke-mcs-importer]"
  project = var.project
  role    = "roles/compute.networkViewer"
}

# Google Project IAM Member Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam#google_project_iam_member

resource "google_project_iam_member" "container_deployer" {
  for_each = local.container_deployer_service_accounts

  member  = "serviceAccount:${each.value}"
  project = var.project
  role    = "organizations/163313809793/roles/container.deployer"
}

# Google Service Account Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account

resource "google_service_account" "kubernetes_workload_identity" {
  for_each = var.namespaces

  account_id   = "gke-${random_id.this[each.key].hex}-workload-identity"
  display_name = "Kubernetes ${each.key} namespace workload identity service account"
  project      = var.project
}

# Google Service Account IAM Member Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account_iam#google_service_account_iam_member

resource "google_service_account_iam_member" "workload_identity" {
  for_each = var.namespaces

  member             = "serviceAccount:${var.project}.svc.id.goog[${each.key}/${each.key}-workload-identity-sa]"
  role               = "roles/iam.workloadIdentityUser"
  service_account_id = google_service_account.kubernetes_workload_identity[each.key].name
}

# Random ID Resource
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id

resource "random_id" "this" {
  for_each = var.namespaces

  byte_length = 3
  prefix      = "tf"
}
