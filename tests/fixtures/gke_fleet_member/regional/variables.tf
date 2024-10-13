# Input Variables
# https://www.terraform.io/language/values/variables

variable "enable_gke_hub_host" {
  type = bool
}

variable "gke_hub_memberships" {
  type = map(object({
    cluster_id = string
  }))
  default = {}
}

variable "master_ipv4_cidr_block" {
  type = string
}

variable "node_pools" {
  type = map(object({
    auto_repair                              = optional(bool)
    auto_upgrade                             = optional(bool)
    disk_size_gb                             = optional(number)
    disk_type                                = optional(string)
    image_type                               = optional(string)
    machine_type                             = optional(string)
    max_node_count                           = optional(number, 3)
    min_node_count                           = optional(number, 1)
    node_count                               = optional(number)
    oauth_scopes                             = optional(list(string), ["https://www.googleapis.com/auth/cloud-platform"])
    upgrade_settings_batch_node_count        = optional(number)
    upgrade_settings_batch_percentage        = optional(number)
    upgrade_settings_batch_soak_duration     = optional(string)
    upgrade_settings_node_pool_soak_duration = optional(string)
    upgrade_settings_max_surge               = optional(number)
    upgrade_settings_max_unavailable         = optional(number, 1)
    upgrade_settings_strategy                = optional(string, "SURGE")
  }))
}

variable "project" {
  type = string
}

variable "vpc_host_project_id" {
  type = string
}
