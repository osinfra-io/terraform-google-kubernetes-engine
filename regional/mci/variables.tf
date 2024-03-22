# Input Variables
# https://www.terraform.io/language/values/variables

variable "istio_gateway_mci_global_address" {
  description = "The IP address for the Istio Gateway multi-cluster ingress"
  type        = string
  default     = ""
}

variable "multi_cluster_service_clusters" {
  description = "List of clusters to be included in the MultiClusterService"
  type = list(object({
    link = string
  }))
  default = []
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}
