# Input Variables
# https://www.terraform.io/language/values/variables

variable "mci_istio_gateway_domains" {
  description = "List of domain names for the multi-cluster ingress Istio gateway managed certificate"
  type        = list(string)
  default     = []
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
