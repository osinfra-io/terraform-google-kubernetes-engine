# Input Variables
# https://www.terraform.io/language/values/variables

variable "region" {
  type    = string
  default = "us-east1"
}

variable "project_id" {
  type    = string
  default = "test-gke-fleet-host-tf64-sb"
}
