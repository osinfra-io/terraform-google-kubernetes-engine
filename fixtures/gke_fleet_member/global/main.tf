module "test" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test.
  # source = "github.com/osinfra-io/terraform-google-kubernetes//global?ref=v0.0.0"

  source = "../../../global"

  gke_fleet_host_project_id = var.gke_fleet_host_project_id

  namespaces = {
    istio-system = {
      google_service_account = "plt-lz-testing-github@ptl-lz-terraform-tf91-sb.iam.gserviceaccount.com"
    }
  }

  project = var.project
}
