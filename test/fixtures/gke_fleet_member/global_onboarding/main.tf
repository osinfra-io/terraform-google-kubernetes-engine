module "test" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test.
  # source = "git@github.com:osinfra-io/terraform-google-kubernetes-engine//global/onboarding?ref=v0.0.0"

  source = "../../../../global/onboarding"

  google_service_account = "plt-lz-testing-github@ptl-lz-terraform-tf91-sb.iam.gserviceaccount.com"

  namespaces = {
    istio-system = {}
  }

  project_id = var.project_id
}
