# Input Variables
# https://www.terraform.io/language/values/variables

variable "gke_fleet_host_project_id" {
  type    = string
  default = "test-gke-fleet-host-tf64-sb"
}

variable "region" {
  type    = string
  default = "us-east1"
}

variable "project_id" {
  type    = string
  default = "test-gke-fleet-service-tf3e-sb"
}
