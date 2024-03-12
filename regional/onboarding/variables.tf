# Input Variables
# https://www.terraform.io/language/values/variables

variable "google_service_account" {
  description = "The email address of the pre-existing Google service account to use for the namespace administrator"
  type        = string
}

variable "namespaces" {
  description = "A map of namespaces"

  type = map(object({
    istio_injection = optional(string, "disabled")
  }))
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}

variable "workload_identity_service_account_emails" {
  description = "A map of workload identity service account emails for each namespace"
  type        = map(string)
}
