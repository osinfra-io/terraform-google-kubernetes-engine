# Input Variables
# https://www.terraform.io/language/values/variables

variable "gke_fleet_host_project_id" {
  type    = string
  default = "test-gke-fleet-host-tf64-sb"
}

variable "project_id" {
  type    = string
  default = "test-gke-fleet-host-tf64-sb"
}

variable "vpc_host_project_id" {
  type    = string
  default = "test-vpc-host-tf12-sb"
}
