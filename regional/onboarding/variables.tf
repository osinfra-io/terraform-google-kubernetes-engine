# Input Variables
# https://www.terraform.io/language/values/variables

variable "namespaces" {
  description = "A map of namespaces with the Google service account used for the namespace administrator and whether Istio injection is enabled or disabled"
  default     = {}

  type = map(object({
    google_service_account = string
    istio_injection        = optional(string, "disabled")
  }))
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}

variable "workload_identity_service_account_emails" {
  description = "A map of workload identity service account emails for each namespace. Each key should be a namespace name, and the value should be the email address of the service account to associate with that namespace."
  type        = map(string)
}
