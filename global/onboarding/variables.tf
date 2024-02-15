# Input Variables
# https://www.terraform.io/language/values/variables

variable "vpc_host_project_id" {
  description = "The project ID and number of the GKE Hub host project"
  type = map(object({
    project_number = string
  }))
  default = {}
}

variable "google_service_account" {
  description = "The optional email address of the pre-existing Google service account to use for the namespace administrator"
  type        = string
  default     = ""
}

variable "namespace_admin" {
  description = "The namespace administrator service account name, required if google_service_account is not set"
  type        = string
  default     = ""
}

variable "namespaces" {
  description = "A map of namespaces"

  type = map(object({
    istio_injection = optional(string, "disabled")
  }))

  # This is an attempt at solving #54. Even though this change doesn't help us to fail fast
  # in all conditions, it will fail with a useful error message on terraform plan. The terraform
  # validate command is intended for static validation of the configuration.

  validation {
    condition     = alltrue([for k in keys(var.namespaces) : length(k) <= 20])
    error_message = "Each namespace name must not contain more than 20 characters."
  }
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}
