module "test" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test.
  # source = "git@github.com:osinfra-io/terraform-google-kubernetes-engine//global/onboarding?ref=v0.0.0"

  source = "../../../../global/onboarding"

  namespaces = {
    foo = {
      istio_injection = "enabled"
    }
    bar = {
      istio_injection = "disabled"
    }
  }

  project_id      = "test-gke-fleet-host-tf64-sb"
  namespace_admin = "test"
}

module "test_service_account" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test.
  # source = "git@github.com:osinfra-io/terraform-google-kubernetes-engine//global/onboarding?ref=v0.0.0"

  source = "../../../../global/onboarding"

  google_service_account = "plt-lz-testing-github@ptl-lz-terraform-tf91-sb.iam.gserviceaccount.com"

  namespaces = {
    cat = {}
    dog = {}
  }

  project_id = "test-gke-fleet-host-tf64-sb"
}
