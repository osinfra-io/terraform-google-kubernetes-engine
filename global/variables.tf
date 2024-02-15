# Input Variables
# https://www.terraform.io/language/values/variables

variable "gke_fleet_host_project_id" {
  type        = string
  description = "The project ID of the GKE Hub host project"
  default     = null
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}
