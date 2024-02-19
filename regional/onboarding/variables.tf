# Input Variables
# https://www.terraform.io/language/values/variables

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

  validation {
    condition     = alltrue([for k in keys(var.namespaces) : length(k) <= 20])
    error_message = "Each namespace name must not contain more than 20 characters."
  }
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}
