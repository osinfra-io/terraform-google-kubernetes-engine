# Input Variables
# https://www.terraform.io/language/values/variables

variable "gke_fleet_host_project_id" {
  type        = string
  description = "The project ID of the GKE Hub host project"
  default     = ""
}

variable "namespaces" {
  description = "A map of namespaces with the Google service account used for the namespace administrator and whether Istio injection is enabled or disabled"
  default     = {}

  type = map(object({
    google_service_account = string
    istio_injection        = optional(string, "disabled")
  }))
}

variable "istio_gateway_dns" {
  description = "Map of attributes for the Istio gateway domain names, it is also used to create the managed certificate resource"
  type = map(object({
    managed_zone = string
    project      = string
  }))
  default = {}
}

variable "project" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}
