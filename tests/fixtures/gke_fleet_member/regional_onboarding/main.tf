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

data "terraform_remote_state" "main" {
  backend   = "gcs"
  workspace = "mock"

  config = {
    bucket = "mock"
  }
}

data "terraform_remote_state" "regional" {
  backend   = "gcs"
  workspace = "mock"

  config = {
    bucket = "mock"
  }
}

module "test" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test.
  # source = "git@github.com:osinfra-io/terraform-google-kubernetes-engine//regional/onboarding?ref=v0.0.0"

  source = "../../../../regional/onboarding"

  namespaces = {

    namespace-a = {
      google_service_account = var.google_service_account
      istio_injection        = "disabled"
    }

    namespace-b = {
      google_service_account = var.google_service_account
      istio_injection        = "enabled"
    }
  }

  project = var.project

  workload_identity_service_account_emails = data.terraform_remote_state.main.outputs.workload_identity_service_account_emails
}
