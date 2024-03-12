# Input Variables
# https://www.terraform.io/language/values/variables

variable "dns_project_id" {
  type    = string
  default = "test-vpc-host-tf12-sb"
}

variable "istio_gateway_domain" {
  description = "The top level domain for the Istio gateway"
  type        = string
  default     = "test.gcp.osinfra.io"
}

variable "project_id" {
  type    = string
  default = "test-gke-fleet-host-tf64-sb"
}
