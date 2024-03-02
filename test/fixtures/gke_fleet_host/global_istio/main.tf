module "test" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test.
  # source = "github.com/osinfra-io/terraform-google-kubernetes//global/istio/?ref=v0.0.0"

  source = "../../../../global/istio"

  istio_gateway_ssl = [
    # Common Name:
    "gateway.test.gcp.osinfra.io",

    # Subject Alternative Names:
    "stream-team.test.gcp.osinfra.io"
  ]

  project_id = var.project_id
}
