# Required Providers
# https://opentofu.org/docs/language/providers/requirements

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

# Remote State Data Source
# https://opentofu.org/docs/language/state/remote

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
