# Terraform Local Values
# https://www.terraform.io/docs/language/values/locals.html

locals {

  # To provide a simple interface for cluster autoscaling, we use this local to provide
  # clarity to the user on what resources are available for autoscaling. You can only have a
  # single resource type of cpu and memory.

  autoscaling_resource_limits = var.cluster_autoscaling.enabled ? [
    {
      resource_type = "cpu"
      minimum       = var.cluster_autoscaling.resource_limits_min_cpu_cores
      maximum       = var.cluster_autoscaling.resource_limits_max_cpu_cores
    },
    {
      resource_type = "memory"
      minimum       = var.cluster_autoscaling.resource_limits_min_memory_gb
      maximum       = var.cluster_autoscaling.resource_limits_max_memory_gb
    }
  ] : []

  environment = (
    terraform.workspace == "default" ?
    "mock-environment" :
    regex(".*-(?P<environment>[^-]+)$", terraform.workspace)["environment"]
  )

  kms_crypto_keys = {
    cluster-boot-disk-encryption = {

      # For CMEK-protected node boot disks and CMEK-protected attached disks, this Compute Engine service account is the account
      # which requires permissions to do encryption using your Cloud KMS key. This is true even if you are using a custom service
      # account on your nodes.

      service_account = "serviceAccount:service-${data.google_project.this.number}@compute-system.iam.gserviceaccount.com"
    }

    cluster-database-encryption = {
      service_account = "serviceAccount:service-${data.google_project.this.number}@container-engine-robot.iam.gserviceaccount.com"
    }
  }

  name    = local.zone == null ? "${var.cluster_prefix}-${local.region}" : "${var.cluster_prefix}-${local.region}-${local.zone}"
  network = "projects/${var.vpc_host_project_id}/global/networks/${var.network}"

  region = (
    terraform.workspace == "default" ?
    "mock-region" :
    (regex("^(?P<region>[^-]+-[^-]+)", terraform.workspace)["region"])
  )

  subnet = "projects/${var.vpc_host_project_id}/regions/${local.region}/subnetworks/${var.subnet}"

  zone = (
    terraform.workspace == "default" ?
    "mock-zone" :
    (
      length(regex("^(?P<region>[^-]+-[^-]+)(?:-(?P<zone>[^-]+))?$", terraform.workspace)["zone"]) > 0 ?
      regex("^(?P<region>[^-]+-[^-]+)(?:-(?P<zone>[^-]+))?$", terraform.workspace)["zone"] :
      null
    )
  )
}
