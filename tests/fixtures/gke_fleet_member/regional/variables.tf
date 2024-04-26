# Input Variables
# https://www.terraform.io/language/values/variables

variable "project" {
  type    = string
  default = "test-gke-fleet-member-tfc5-sb"
}

variable "region" {
  type    = string
  default = "us-east1"
}

variable "vpc_host_project_id" {
  type    = string
  default = "test-default-tf75-sb"
}
