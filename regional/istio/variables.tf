variable "artifact_registry" {
  description = "The registry to pull the images from"
  type        = string
  default     = "us-docker.pkg.dev/plt-lz-services-tf79-prod/platform-docker-virtual"
}

variable "cluster_prefix" {
  description = "Prefix for your cluster name"
  type        = string
}

variable "enable_istio_gateway" {
  description = "Enable the Istio gateway, used for ingress traffic into the mesh"
  type        = bool
  default     = false
}

variable "environment" {
  description = "The environment suffix for example: `sb` (Sandbox), `nonprod` (Non-Production), `prod` (Production)"
  type        = string
  default     = "sb"
}

variable "gateway_autoscale_min" {
  description = "The minimum number of gateway replicas to run"
  type        = number
  default     = 1
}

variable "istio_chart_repository" {
  description = "The repository to pull the Istio Helm chart from"
  type        = string
  default     = "https://istio-release.storage.googleapis.com/charts"
}

variable "ingress_istio_gateway_dns" {
  description = "Map of attributes for the ingress Istio gateway domain names, it is also used to create the managed certificate resource"
  type = map(object({
    managed_zone = string
    project      = string
  }))
  default = {}
}

# If you're changing the version of Istio here, make sure to update the version in the script
# tools/crds-upgrade.sh as well. Helm does not upgrade or delete CRDs when performing an upgrade.
# Because of this restriction, an additional step is required when upgrading Istio with Helm.

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
