module "test" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test.
  # source = "github.com/osinfra-io/terraform-google-kubernetes//global?ref=v0.0.0"

  source = "../../../../global"

  google_service_account = "plt-lz-testing-github@ptl-lz-terraform-tf91-sb.iam.gserviceaccount.com"

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
    bar = {
      istio_injection = "disabled"
    }

    foo = {
      istio_injection = "enabled"
    }

    istio-ingress = {
      istio_injection = "enabled"
    }

    istio-system = {}
  }

  project_id = var.project_id
}
