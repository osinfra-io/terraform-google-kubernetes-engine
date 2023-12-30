# Google Project IAM Member Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam#google_project_iam_member


resource "google_project_iam_member" "container_deployer" {
  member  = "serviceAccount:${local.google_service_account}"
  project = var.project_id
  role    = "organizations/163313809793/roles/container.deployer"
}

# Google Service Account Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account

resource "google_service_account" "kubernetes_namespace_admin" {
  count = var.google_service_account == "" ? 1 : 0

  account_id   = "${var.namespace_admin}-k8s-ns-admin"
  display_name = "Kubernetes Namespace Admin Service Account"
  project      = var.project_id
}

resource "google_service_account" "kubernetes_workload_identity" {
  for_each = var.namespaces

  account_id   = "${each.key}-k8s-wif"
  display_name = "Kubernetes Workload Identity Service Account"
  project      = var.project_id
}

# Google Service Account IAM Member Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account_iam#google_service_account_iam_member

resource "google_service_account_iam_member" "workload_identity" {
  for_each = var.namespaces

  member             = "serviceAccount:${var.project_id}.svc.id.goog[${each.key}/workload-identity]"
  role               = "roles/iam.workloadIdentityUser"
  service_account_id = google_service_account.kubernetes_workload_identity[each.key].name
}

# Google Service Account Key Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account_key

resource "google_service_account_key" "kubernetes_namespace_admin" {
  count = var.google_service_account == "" ? 1 : 0

  service_account_id = google_service_account.kubernetes_namespace_admin.0.name
}
