# Terraform Local Values
# https://www.terraform.io/docs/language/values/locals.html

locals {

  # To provide a simple interface for cluster autoscaling, we use this local to provide
  # clarity to the user on what resources are available for autoscaling. You can only have a
  # single resource type of cpu and memory.

  autoscaling_resource_limits = var.cluster_autoscaling.enabled ? [
    {
      resource_type = "cpu"
      minimum       = var.cluster_autoscaling.min_cpu_cores
      maximum       = var.cluster_autoscaling.max_cpu_cores
    },
    {
      resource_type = "memory"
      minimum       = var.cluster_autoscaling.min_memory_gb
      maximum       = var.cluster_autoscaling.max_memory_gb
    }
  ] : []

  labels = merge(
    {
      cost-center = var.cost_center
    },
    var.labels
  )

  name    = "${var.cluster_prefix}-${var.region}"
  network = "projects/${var.host_project_id}/global/networks/${var.network}"
  subnet  = "projects/${var.host_project_id}/regions/${var.region}/subnetworks/${var.subnet}"
}
