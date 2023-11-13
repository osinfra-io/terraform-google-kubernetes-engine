# Input Variables
# https://www.terraform.io/language/values/variables

variable "cluster_autoscaling" {
  description = "Per-cluster configuration of node auto-provisioning with cluster autoscaler to automatically adjust the size of the cluster and create/delete node pools based on the current needs of the cluster's workload"
  type = object({
    auto_repair         = optional(bool)
    autoscaling_profile = optional(string, "OPTIMIZE_UTILIZATION")
    disk_type           = optional(string)
    enabled             = optional(bool, false)
    image_type          = optional(string)
    min_cpu_cores       = optional(number, 0)
    max_cpu_cores       = optional(number, 4)
    min_memory_gb       = optional(number, 0)
    max_memory_gb       = optional(number, 32)
    oauth_scopes        = optional(list(string), ["https://www.googleapis.com/auth/cloud-platform"])
  })
  default = {}
}

variable "cluster_prefix" {
  description = "Prefix for your cluster name"
  type        = string
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

variable "host_project_id" {
  description = "Host project for the shared VPC"
  type        = string
}

variable "kubernetes_daily_maintenance_window" {
  description = "Time window specified for daily maintenance operations"
  type        = string
  default     = "06:00"
}

variable "labels" {
  description = "The Kubernetes labels (key/value pairs) to be applied to each node"
  type        = map(string)
  default     = {}
}

variable "master_ipv4_cidr_block" {
  type        = string
  description = "The IP range in CIDR notation to use for the hosted master network"
}

variable "node_pools" {
  description = "List of maps containing node pools"
  type = map(object({
    auto_repair     = optional(bool)
    auto_upgrade    = optional(bool)
    disk_size_gb    = optional(number)
    disk_type       = optional(string)
    image_type      = optional(string)
    machine_type    = optional(string)
    max_node_count  = optional(number, 3)
    max_surge       = optional(number)
    max_unavailable = optional(number)
    min_node_count  = optional(number, 0)
    node_count      = optional(number)
    oauth_scopes    = optional(list(string), ["https://www.googleapis.com/auth/cloud-platform"])
    service_account = optional(string)
  }))
  default = {}
}

variable "network" {
  description = "The name or self_link of the Google Compute Engine network to which the cluster is connected"
  type        = string
  default     = "default"
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}

variable "project_number" {
  description = "The number of the project in which the resource belongs"
  type        = number
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
