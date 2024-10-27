# Required Providers
# https://developer.hashicorp.com/terraform/language/providers/requirements

terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    google = {
      source = "hashicorp/google"
    }
  }
}

# Kubernetes Provider
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest

provider "kubernetes" {
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.this.master_auth[0].cluster_ca_certificate
  )

  host  = data.google_container_cluster.this.endpoint
  token = data.google_client_config.current.access_token
}

# Google Client Config Data Source
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config

data "google_client_config" "current" {
}

# Google Container Cluster Data Source
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/container_cluster

data "google_container_cluster" "this" {
  name     = "mock-cluster"
  location = "mock-region"
  project  = var.project
}

# Remote State Data Source
# https://www.terraform.io/language/state/remote-state-data

data "terraform_remote_state" "main" {
  backend   = "gcs"
  workspace = "mock"

  config = {
    bucket = "mock"
  }
}

module "test" {
  source = "../../../../regional/onboarding"

  namespaces                               = var.namespaces
  project                                  = var.project
  workload_identity_service_account_emails = data.terraform_remote_state.main.outputs.workload_identity_service_account_emails
}
