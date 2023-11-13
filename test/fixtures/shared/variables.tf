# Input Variables
# https://www.terraform.io/language/values/variables

variable "host_project_id" {
  type    = string
  default = "testing-kitchen-tfd2-sb"
}
variable "master_ipv4_cidr_block" {
  type    = string
  default = "10.61.224.0/28"
}

variable "project_id" {
  type    = string
  default = "testing-kitchen-tfbd-sb"
}

variable "project_number" {
  type    = string
  default = "291676312309"
}

variable "region" {
  type    = string
  default = "us-east1"
}
