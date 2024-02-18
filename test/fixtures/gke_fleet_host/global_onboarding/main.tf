module "test" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test.
  # source = "git@github.com:osinfra-io/terraform-google-kubernetes-engine//global/onboarding?ref=v0.0.0"

  source = "../../../../global/onboarding"

  namespace_admin = "test"

  namespaces = {
    foo = {
      istio_injection = "enabled"
    }
    bar = {
      istio_injection = "disabled"
    }
  }

  project_id = var.project_id
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

  project_id = var.project_id
}
