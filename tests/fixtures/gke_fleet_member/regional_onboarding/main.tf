# Kubernetes Provider
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest

provider "kubernetes" {
  cluster_ca_certificate = base64decode(
    local.regional.cluster_ca_certificate
  )

  host  = "https://${local.regional.cluster_endpoint}"
  token = data.google_client_config.current.access_token
}

# Google Client Config Data Source
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config

data "google_client_config" "current" {
}

# Remote State Data Source
# https://www.terraform.io/language/state/remote-state-data

# This is the preferred way to get the remote state data from other terraform workspaces and how we recommend
# you do it in your root module.

data "terraform_remote_state" "global" {
  backend   = "gcs"
  workspace = "kitchen-terraform-gke-fleet-host-global-gcp"

  config = {
    bucket = "plt-lz-testing-2c8b-sb"
  }
}

data "terraform_remote_state" "regional" {
  backend   = "gcs"
  workspace = "kitchen-terraform-gke-fleet-member-regional-gcp"

  config = {
    bucket = "plt-lz-testing-2c8b-sb"
  }
}

module "test" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test.
  # source = "git@github.com:osinfra-io/terraform-google-kubernetes-engine//regional/onboarding?ref=v0.0.0"

  source = "../../../../regional/onboarding"


  namespaces = {
    istio-system = {
      google_service_account = "plt-lz-testing-github@ptl-lz-terraform-tf91-sb.iam.gserviceaccount.com"
    }
  }

  project = var.project

  workload_identity_service_account_emails = data.terraform_remote_state.global.outputs.workload_identity_service_account_emails
}
