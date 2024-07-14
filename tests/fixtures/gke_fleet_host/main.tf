# Required Providers
# https://developer.hashicorp.com/terraform/language/providers/requirements

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

module "test" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test.
  # source = "github.com/osinfra-io/terraform-google-kubernetes//global?ref=v0.0.0"

  source = "../../../"

  namespaces = {
    gke-java-example = {
      google_service_account = var.google_service_account
      istio_injection        = "disabled"
    }

    gke-go-example = {
      google_service_account = var.google_service_account
      istio_injection        = "disabled"
    }

    istio-ingress = {
      google_service_account = var.google_service_account
      istio_injection        = "enabled"
    }

    istio-system = {
      google_service_account = var.google_service_account
    }
  }

  project = var.project
}
