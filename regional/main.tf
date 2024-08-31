# Google Container Engine Versions Data Source
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/container_engine_versions

data "google_container_engine_versions" "this" {
  project  = var.project
  location = var.region
}

# Google Project Data Source
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project

data "google_project" "this" {
  project_id = var.project
}

# Google Container Cluster Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster

resource "google_container_cluster" "this" {


  # Ensure Network Policy is enabled on Kubernetes Engine Clusters (False Positive)
  # Network policy enforcement is built into GKE Dataplane V2
  # https://github.com/bridgecrewio/checkov/issues/6357
  # checkov:skip=CKV_GCP_12

  # Ensure master authorized networks is set to enabled in GKE clusters
  # checkov:skip=CKV_GCP_20

  # Ensure use of Binary Authorization
  # checkov:skip=CKV_GCP_66

  # Ensure the GKE Metadata Server is Enabled (False Positive)
  # Removal of the default node pool is a best practice to ensure that all nodes are managed by Terraform.
  # The Metadata server is enabled in the google_container_node_pool resource.
  # checkov:skip=CKV_GCP_69

  authenticator_groups_config {
    security_group = "gke-security-groups@osinfra.io"
  }

  cluster_autoscaling {
    autoscaling_profile = var.cluster_autoscaling.autoscaling_profile
    enabled             = var.cluster_autoscaling.enabled

    dynamic "auto_provisioning_defaults" {
      for_each = var.cluster_autoscaling.enabled ? [var.cluster_autoscaling.enabled] : []

      content {
        boot_disk_kms_key = google_kms_crypto_key.this["cluster-boot-disk-encryption"].id
        disk_type         = var.cluster_autoscaling.disk_type
        image_type        = var.cluster_autoscaling.image_type
        oauth_scopes      = var.cluster_autoscaling.oauth_scopes
        service_account   = google_service_account.gke_operations.email

        management {
          auto_repair  = true
          auto_upgrade = true
        }

        shielded_instance_config {
          enable_integrity_monitoring = true
          enable_secure_boot          = true
        }

        dynamic "upgrade_settings" {
          for_each = var.cluster_autoscaling.upgrade_settings_strategy == "SURGE" || var.cluster_autoscaling.upgrade_settings_strategy == "BLUE_GREEN" ? [var.cluster_autoscaling.upgrade_settings_strategy] : []
          content {
            max_surge       = var.cluster_autoscaling.upgrade_settings_strategy == "SURGE" ? var.cluster_autoscaling.upgrade_settings_max_surge : null
            max_unavailable = var.cluster_autoscaling.upgrade_settings_strategy == "SURGE" ? var.cluster_autoscaling.upgrade_settings_max_unavailable : null

            dynamic "blue_green_settings" {
              for_each = var.cluster_autoscaling.upgrade_settings_strategy == "BLUE_GREEN" ? [var.cluster_autoscaling.upgrade_settings_strategy] : []
              content {
                node_pool_soak_duration = var.cluster_autoscaling.upgrade_settings_node_pool_soak_duration
                standard_rollout_policy {
                  batch_node_count    = var.cluster_autoscaling.upgrade_settings_batch_node_count
                  batch_percentage    = var.cluster_autoscaling.upgrade_settings_batch_percentage
                  batch_soak_duration = var.cluster_autoscaling.upgrade_settings_batch_soak_duration
                }
              }
            }
          }
        }
      }
    }

    dynamic "resource_limits" {
      for_each = local.autoscaling_resource_limits
      content {
        resource_type = lookup(resource_limits.value, "resource_type")
        minimum       = lookup(resource_limits.value, "minimum")
        maximum       = lookup(resource_limits.value, "maximum")
      }
    }
  }

  cost_management_config {
    enabled = true
  }

  database_encryption {
    key_name = google_kms_crypto_key.this["cluster-database-encryption"].id
    state    = "ENCRYPTED"
  }

  enable_intranode_visibility = true
  enable_shielded_nodes       = true
  datapath_provider           = "ADVANCED_DATAPATH"
  deletion_protection         = var.enable_deletion_protection

  # If you're using google_container_node_pool objects with no default node pool, you'll need to set this to a value
  # of at least 1, alongside setting remove_default_node_pool to true.

  initial_node_count = 1

  ip_allocation_policy {
    cluster_secondary_range_name  = var.cluster_secondary_range_name
    services_secondary_range_name = var.services_secondary_range_name
  }

  location = var.region

  maintenance_policy {
    daily_maintenance_window {
      start_time = var.kubernetes_daily_maintenance_window
    }
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  min_master_version = "latest"

  monitoring_config {
    advanced_datapath_observability_config {
      enable_metrics = true
      enable_relay   = false
    }

    enable_components = [
      "APISERVER",
      "CONTROLLER_MANAGER",
      "DAEMONSET",
      "DEPLOYMENT",
      "HPA",
      "POD",
      "SCHEDULER",
      "STATEFULSET",
      "STORAGE",
      "SYSTEM_COMPONENTS"
    ]
  }

  name = local.name

  network = local.network

  # We intentionally support only a single zone for node locations. This is to ensure we do not see hot spots in the cluster
  # when it comes to POD scheduling and locality based load balancing.

  node_locations = var.node_location != null ? [var.node_location] : null
  project        = var.project

  release_channel {
    channel = var.release_channel
  }

  remove_default_node_pool = true
  resource_labels          = var.resource_labels
  subnetwork               = local.subnet

  # Workload Identity allows workloads in your GKE clusters to impersonate Identity and Access Management (IAM) service accounts
  # to access Google Cloud services.
  # https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity

  workload_identity_config {
    workload_pool = "${var.project}.svc.id.goog"
  }

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
    master_global_access_config {
      enabled = true
    }
  }

  lifecycle {
    ignore_changes = [

      # Cluster master version is managed by the release channel. Google upgrades clusters and nodes automatically.
      # For more control over which auto-upgrades your cluster and its nodes receive, you can enroll it in a release channel.

      min_master_version
    ]
  }
}

# Google Container Node Pool Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool

resource "google_container_node_pool" "this" {
  for_each = var.node_pools

  autoscaling {
    max_node_count = each.value.max_node_count
    min_node_count = each.value.min_node_count
  }

  cluster            = google_container_cluster.this.name
  initial_node_count = each.value.node_count
  location           = google_container_cluster.this.location

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  name = each.key

  node_config {
    boot_disk_kms_key = google_kms_crypto_key.this["cluster-boot-disk-encryption"].id
    disk_size_gb      = each.value.disk_size_gb
    disk_type         = each.value.disk_type
    image_type        = each.value.image_type
    labels            = var.labels
    machine_type      = each.value.machine_type

    metadata = {
      "disable-legacy-endpoints" = true
    }

    oauth_scopes    = each.value.oauth_scopes
    service_account = google_service_account.gke_operations.email

    shielded_instance_config {
      enable_integrity_monitoring = true
      enable_secure_boot          = true
    }

    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }

  node_locations = google_container_cluster.this.node_locations
  project        = var.project

  upgrade_settings {
    max_surge       = each.value.upgrade_settings_max_surge
    max_unavailable = each.value.upgrade_settings_max_unavailable
  }
}

# Google GKEHub Feature Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/gke_hub_feature

resource "google_gke_hub_feature" "multi_cluster_ingress" {
  count = var.enable_gke_hub_host ? 1 : 0

  labels   = var.labels
  location = "global"
  name     = "multiclusteringress"
  project  = var.project

  spec {
    multiclusteringress {
      config_membership = google_gke_hub_membership.host.0.name
    }
  }
}

resource "google_gke_hub_feature" "multi_cluster_service_discovery" {
  count = var.enable_gke_hub_host ? 1 : 0

  name     = "multiclusterservicediscovery"
  labels   = var.labels
  location = "global"
  project  = var.project

}

# Google GKEHub Membership Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/gke_hub_membership

resource "google_gke_hub_membership" "host" {
  count = var.enable_gke_hub_host ? 1 : 0

  endpoint {
    gke_cluster {
      resource_link = google_container_cluster.this.id
    }
  }

  labels        = var.labels
  membership_id = google_container_cluster.this.name
  project       = var.project
}

# This is the resource for registering clusters to the GKE Hub.

resource "google_gke_hub_membership" "clusters" {
  for_each = var.enable_gke_hub_host ? var.gke_hub_memberships : {}

  authority {
    issuer = "https://container.googleapis.com/v1/${each.value.cluster_id}"
  }

  endpoint {
    gke_cluster {
      resource_link = each.value.cluster_id
    }
  }

  labels        = var.labels
  membership_id = each.key
  project       = var.project
}

# KMS CryptoKey Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key

resource "google_kms_crypto_key" "this" {

  # See comment below for why we can't use the lifecycle block to prevent destroy on this resource.
  # checkov:skip=CKV_GCP_82

  for_each = toset([
    "cluster-boot-disk-encryption",
    "cluster-database-encryption"
  ])

  key_ring        = google_kms_key_ring.cluster_encryption.id
  labels          = var.labels
  name            = "${each.key}-${random_id.this.hex}"
  rotation_period = "7776000s"

  # We can't use the lifecycle block to prevent destroy on this resource for testing purposes.

  # CryptoKeys cannot be deleted from Google Cloud Platform. Destroying a Terraform-managed CryptoKey will
  # remove it from state and delete all CryptoKeyVersions, rendering the key unusable, but will not delete
  # the resource from the project. When Terraform destroys these keys, any data previously encrypted with
  # these keys will be irrecoverable. For this reason, it is strongly recommended that you add lifecycle
  # hooks to the resource to prevent accidental destruction.

  # lifecycle {
  #   prevent_destroy = true
  # }
}

# KMS CryptoKey IAM Member Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_kms_crypto_key_iam

resource "google_kms_crypto_key_iam_member" "this" {
  for_each = toset([
    "cluster-boot-disk-encryption",
    "cluster-database-encryption"
  ])

  crypto_key_id = google_kms_crypto_key.this[each.key].id
  member        = "serviceAccount:service-${data.google_project.this.number}@container-engine-robot.iam.gserviceaccount.com"
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
}

# KMS Key Ring Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring

resource "google_kms_key_ring" "cluster_encryption" {
  location = var.region
  name     = "${local.name}-cluster-encryption-${random_id.this.hex}"
  project  = var.project

  # We can't use the lifecycle block to prevent destroy on this resource for testing purposes.

  # KeyRings cannot be deleted from Google Cloud Platform. Destroying a Terraform-managed KeyRing will remove it from
  # state but will not delete the resource from the project.

  # lifecycle {
  #   prevent_destroy = true
  # }
}

# CIS GKE Benchmark Recommendation: 6.2.1. Prefer not running GKE clusters using the Compute Engine
# default service account

# You should create and use a minimally privileged service account for your nodes to use instead of the
# Compute Engine default service account.

# https://cloud.google.com/kubernetes-engine/docs/how-to/hardening-your-cluster#use_least_privilege_sa

# Project IAM Member Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam_member

resource "google_project_iam_member" "gke_operations" {
  for_each = toset([
    "roles/autoscaling.metricsWriter",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer"
  ])

  member  = "serviceAccount:${google_service_account.gke_operations.email}"
  project = var.project
  role    = each.value
}

# Service Account Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account

resource "google_service_account" "gke_operations" {
  account_id   = "gke-${random_id.this.hex}"
  display_name = "Kubernetes minimum privilege service account for: ${local.name}"
  project      = var.project
}

# Random ID Resource
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id

resource "random_id" "this" {
  prefix      = "tf"
  byte_length = "2"
}
