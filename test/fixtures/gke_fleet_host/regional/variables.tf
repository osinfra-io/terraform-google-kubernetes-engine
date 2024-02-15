# Input Variables
# https://www.terraform.io/language/values/variables

variable "region" {
  type    = string
  default = "us-east1"
}

variable "vpc_host_project_id" {
  type    = string
  default = "test-vpc-host-tf12-sb"
}
