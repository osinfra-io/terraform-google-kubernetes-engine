# Input Variables
# https://www.terraform.io/language/values/variables

variable "gke_fleet_host_project_id" {
  type = string
}

variable "google_service_account" {
  type = string
}

variable "project" {
  type = string
}

variable "namespaces" {
  type = map(object({
    google_service_account = string
    istio_injection        = optional(string, "disabled")
  }))
}

variable "shared_vpc_host_project_id" {
  type = string
}
