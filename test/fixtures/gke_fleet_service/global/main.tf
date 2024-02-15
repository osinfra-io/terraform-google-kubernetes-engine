module "test" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test.
  # source = "github.com/osinfra-io/terraform-google-kubernetes//global?ref=v0.0.0"

  source = "../../../../global"

  gke_fleet_host_project_id = "test-gke-fleet-host-tf64-sb"
  project_id                = "test-gke-fleet-service-tf3e-sb"
}
