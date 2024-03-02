# Google Project Data Source
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project#google_project

data "google_project" "fleet_host" {
  count = var.gke_fleet_host_project_id != null ? 1 : 0

  project_id = var.gke_fleet_host_project_id
}

# Google Compute SSL Policy Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_ssl_policy

resource "google_compute_ssl_policy" "default" {
  name            = "default"
  min_tls_version = "TLS_1_2"
  profile         = "MODERN"
  project         = var.project_id
}

# This section provides an example MCS configuration involving two existing GKE clusters each in a different Shared VPC service project.
# https://cloud.google.com/kubernetes-engine/docs/how-to/msc-setup-with-shared-vpc-networks#two-service-projects-iam

# Google Project IAM Member Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam#google_project_iam_member

# Create IAM binding granting the fleet host project's GKE Hub service account the GKE Service Agent role on the service cluster's project.

resource "google_project_iam_member" "gke_hub_service_agent" {
  count = var.gke_fleet_host_project_id != null ? 1 : 0

  member  = "serviceAccount:service-${data.google_project.fleet_host[count.index].number}@gcp-sa-gkehub.iam.gserviceaccount.com"
  project = var.project_id
  role    = "roles/gkehub.serviceAgent"
}

# Create IAM binding granting the fleet host project's MCS service account the MCS Service Agent role on the service cluster's project.

resource "google_project_iam_member" "multi_cluster_service_agent" {
  count = var.gke_fleet_host_project_id != null ? 1 : 0

  member  = "serviceAccount:service-${data.google_project.fleet_host[count.index].number}@gcp-sa-mcsd.iam.gserviceaccount.com"
  project = var.project_id
  role    = "roles/multiclusterservicediscovery.serviceAgent"
}

# Create IAM binding granting each project's MCS service account the Network User role for its own project.
# Because this scenario uses workload identity federation for GKE, each project's MCS Importer GKE service
# account needs the Network User role for its own project.

# These resources needs a clusters created first, so new infrastructure builds will fail on the global run.
# As a W/A run the regional infrastructure first and then the global infrastructure.

resource "google_project_iam_member" "host_project_network_viewer" {
  count = var.gke_fleet_host_project_id != null ? 1 : 0

  member  = "serviceAccount:${var.gke_fleet_host_project_id}.svc.id.goog[gke-mcs/gke-mcs-importer]"
  project = var.project_id
  role    = "roles/compute.networkViewer"
}

resource "google_project_iam_member" "service_project_network_viewer" {
  count = var.gke_fleet_host_project_id == null ? 1 : 0

  member  = "serviceAccount:${var.project_id}.svc.id.goog[gke-mcs/gke-mcs-importer]"
  project = var.project_id
  role    = "roles/compute.networkViewer"
}
