# Input Variables
# https://www.terraform.io/language/values/variables

variable "istio_gateway_ssl" {
  description = "List of domain names for the Istio gateway SSL SAN certificate"
  type        = list(string)
  default     = []
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}
