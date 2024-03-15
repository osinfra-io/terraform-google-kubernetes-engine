# Input Variables
# https://www.terraform.io/language/values/variables

variable "gke_hub_memberships" {
  type = map(object({
    cluster_id = string
  }))
  default = {}
}

variable "project_id" {
  type    = string
  default = "test-gke-fleet-host-tf64-sb"
}

variable "region" {
  type    = string
  default = "us-east1"
}

variable "vpc_host_project_id" {
  type    = string
  default = "test-vpc-host-tf12-sb"
}
