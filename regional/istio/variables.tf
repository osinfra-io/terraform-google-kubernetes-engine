variable "artifact_registry" {
  description = "The registry to pull the images from"
  type        = string
}

variable "environment" {
  description = "The environment suffix for example: `sb` (Sandbox), `nonprod` (Non-Production), `prod` (Production)"
  type        = string
  default     = "sb"
}

variable "cluster_prefix" {
  description = "Prefix for your cluster name"
  type        = string
}

variable "gateway_autoscale_min" {
  description = "The minimum number of gateway replicas to run"
  type        = number
  default     = 1
}

variable "istio_gateway_ssl" {
  description = "List of domain names for the Istio gateway SSL SAN certificate"
  type        = list(string)
}

# If you're changing the version of Istio here, make sure to update the version in the script
# tools/crds-upgrade.sh as well.

variable "istio_version" {
  description = "The version of istio to install"
  type        = string
  default     = "1.20.3"
}

variable "pilot_autoscale_min" {
  description = "The minimum number of pilot replicas to run"
  type        = number
  default     = 1
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}

variable "region" {
  description = "The region to deploy the resources into"
  type        = string
}
