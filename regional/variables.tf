# Input Variables
# https://www.terraform.io/language/values/variables

variable "cluster_autoscaling" {
  description = "Per-cluster configuration of node auto-provisioning with cluster autoscaler to automatically adjust the size of the cluster and create/delete node pools based on the current needs of the cluster's workload"
  type = object({
    autoscaling_profile                      = optional(string, "OPTIMIZE_UTILIZATION")
    disk_type                                = optional(string)
    enabled                                  = optional(bool, false)
    image_type                               = optional(string)
    oauth_scopes                             = optional(list(string), ["https://www.googleapis.com/auth/cloud-platform"])
    resource_limits_min_cpu_cores            = optional(number, 0)
    resource_limits_min_memory_gb            = optional(number, 0)
    resource_limits_max_cpu_cores            = optional(number, 6)
    resource_limits_max_memory_gb            = optional(number, 32)
    upgrade_settings_batch_node_count        = optional(number)
    upgrade_settings_batch_percentage        = optional(number)
    upgrade_settings_batch_soak_duration     = optional(string)
    upgrade_settings_node_pool_soak_duration = optional(string)
    upgrade_settings_max_surge               = optional(number)
    upgrade_settings_max_unavailable         = optional(number, 1) # https://github.com/hashicorp/terraform-provider-google/issues/17164
    upgrade_settings_strategy                = optional(string, "SURGE")
  })
  default = {}
}

variable "cluster_prefix" {
  description = "Prefix for your cluster name, region, and zone (if applicable) will be added to the end of the cluster name. Must be 20 characters or less"
  type        = string
  validation {
    condition     = length(var.cluster_prefix) <= 20
    error_message = "The cluster prefix must be 20 characters or less."
  }
}

variable "cluster_secondary_range_name" {
  description = "The name of the existing secondary range in the cluster's subnetwork to use for pod IP addresses"
  type        = string
}

variable "enable_deletion_protection" {
  description = "Whether or not to enable deletion protection on the cluster"
  type        = bool
  default     = true
}

variable "enable_gke_hub_host" {
  description = "Whether or not to enable GKE Hub Host"
  type        = bool
  default     = false
}

variable "gke_hub_memberships" {
  description = "The map of GKE Hub Memberships to create"
  type = map(object({
    cluster_id = string
  }))
  default = {}
}

variable "kubernetes_daily_maintenance_window" {
  description = "Time window specified for daily maintenance operations"
  type        = string
  default     = "06:00"
}

variable "labels" {
  description = "A map of key/value pairs to assign to the resources being created"
  type        = map(string)
  default     = {}
}

variable "master_ipv4_cidr_block" {
  type        = string
  description = "The IP range in CIDR notation to use for the hosted master network"
}

variable "node_pools" {
  description = "The node pools to create in the cluster"
  type = map(object({
    auto_repair                              = optional(bool)
    auto_upgrade                             = optional(bool)
    disk_size_gb                             = optional(number)
    disk_type                                = optional(string)
    image_type                               = optional(string)
    machine_type                             = optional(string)
    max_node_count                           = optional(number, 3)
    min_node_count                           = optional(number, 0)
    node_count                               = optional(number)
    oauth_scopes                             = optional(list(string), ["https://www.googleapis.com/auth/cloud-platform"])
    upgrade_settings_batch_node_count        = optional(number)
    upgrade_settings_batch_percentage        = optional(number)
    upgrade_settings_batch_soak_duration     = optional(string)
    upgrade_settings_node_pool_soak_duration = optional(string)
    upgrade_settings_max_surge               = optional(number)
    upgrade_settings_max_unavailable         = optional(number, 1) # https://github.com/hashicorp/terraform-provider-google/issues/17164
    upgrade_settings_strategy                = optional(string, "SURGE")
  }))
  default = {}
}

variable "network" {
  description = "The name or self_link of the Google Compute Engine network to which the cluster is connected"
  type        = string
  default     = "default"
}

variable "node_location" {
  description = "The zone in which the cluster's nodes should be located. If not specified, the cluster's nodes are located across zones in the region"
  type        = string
  default     = null
}

variable "project" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}

variable "region" {
  description = "The region the cluster will run in if not creating a zonal cluster, required for subnet as well"
  type        = string
  default     = "us-east4"
}

variable "release_channel" {
  description = " Configuration options for the Release channel feature, which provide more control over automatic upgrades of your GKE clusters"
  type        = string
  default     = "REGULAR"
}

variable "resource_labels" {
  type        = map(string)
  description = "The GCP labels (key/value pairs) to be applied to each node"
  default     = {}
}

variable "services_secondary_range_name" {
  description = "The name of the existing secondary range in the cluster's subnetwork to use for service"
  type        = string
}

variable "subnet" {
  description = "The name or self_link of the Google Compute Engine subnetwork in which the cluster's instances are launched"
  type        = string
}

variable "vpc_host_project_id" {
  description = "Host project for the shared VPC"
  type        = string
}
