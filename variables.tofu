# Input Variables
# https://opentofu.org/docs/language/values/variables

variable "gke_fleet_host_project_id" {
  type        = string
  description = "The project ID of the GKE Hub host project"
  default     = ""
}

variable "labels" {
  description = "A map of key/value pairs to assign to the resources being created"
  type        = map(string)
  default     = {}
}

variable "namespaces" {
  description = "A map of namespaces with the Google service account used for the namespace administrator and whether Istio injection is enabled or disabled"
  default     = {}

  type = map(object({
    google_service_account = string
    istio_injection        = optional(string, "disabled")
  }))
}

variable "project" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}

variable "shared_vpc_host_project_id" {
  description = "The project ID of the shared VPC host project"
  type        = string
}
