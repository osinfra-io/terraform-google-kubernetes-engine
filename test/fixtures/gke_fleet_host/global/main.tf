module "test" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test.
  # source = "github.com/osinfra-io/terraform-google-kubernetes//global?ref=v0.0.0"

  source = "../../../../global"


  istio_gateway_mci_dns = {
    "gateway.test.gcp.osinfra.io" = {
      managed_zone = "test-gcp-osinfra-io"
      project      = var.dns_project_id
    }

    "stream-team.test.gcp.osinfra.io" = {
      managed_zone = "test-gcp-osinfra-io"
      project      = var.dns_project_id
    }
  }

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

  project_id = var.project_id
}
