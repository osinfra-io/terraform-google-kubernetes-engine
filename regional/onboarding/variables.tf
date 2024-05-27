# Input Variables
# https://www.terraform.io/language/values/variables

variable "istio_control_plane_clusters" {
  description = "The GKE clusters that will be used as Istio control planes"
  type        = string
  default     = null
}

variable "namespaces" {
  description = "A map of namespaces with the Google service account used for the namespace administrator and whether Istio injection is enabled or disabled"
  default     = {}

  type = map(object({
    annotations                  = optional(map(string))
    google_service_account       = string
    istio_control_plane_clusters = optional(string)
    istio_injection              = optional(string, "disabled")
  }))
}

variable "project" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}

variable "workload_identity_service_account_emails" {
  description = "A map of workload identity service account emails for each namespace. Each key should be a namespace name, and the value should be the email address of the service account to associate with that namespace."
  type        = map(string)
}
