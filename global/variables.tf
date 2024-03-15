# Input Variables
# https://www.terraform.io/language/values/variables

variable "gke_fleet_host_project_id" {
  type        = string
  description = "The project ID of the GKE Hub host project"
  default     = ""
}

variable "google_service_account" {
  description = "The email address of the pre-existing Google service account to use for the namespace administrator"
  type        = string
}

variable "namespaces" {
  description = "A map of namespaces"
  default     = {}

  type = map(object({
    istio_injection = optional(string, "disabled")
  }))

  validation {
    condition     = alltrue([for k in keys(var.namespaces) : length(k) <= 20])
    error_message = "Each namespace name must not contain more than 20 characters."
  }
}

variable "istio_gateway_mci_dns" {
  description = "Map of attributes for the Istio gateway multi-cluster ingress domain names, it is also used to create the managed certificate resource"
  type = map(object({
    managed_zone = string
    project      = string
  }))
  default = {}
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}
