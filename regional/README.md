# Terraform Documentation

A child module automatically inherits its parent's default (un-aliased) provider configurations. The provider versions below are informational only and do **not** need to align with the provider configurations from its parent.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.40.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_helpers"></a> [helpers](#module\_helpers) | github.com/osinfra-io/terraform-core-helpers//child | v0.1.2 |

## Resources

| Name | Type |
|------|------|
| [google_cloud_identity_group_membership.registry_readers](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_identity_group_membership) | resource |
| [google_container_cluster.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster) | resource |
| [google_container_node_pool.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool) | resource |
| [google_gke_hub_feature.multi_cluster_ingress](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/gke_hub_feature) | resource |
| [google_gke_hub_membership.clusters](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/gke_hub_membership) | resource |
| [google_gke_hub_membership.host](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/gke_hub_membership) | resource |
| [google_kms_crypto_key.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key) | resource |
| [google_kms_crypto_key_iam_member.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_member) | resource |
| [google_kms_key_ring.cluster_encryption](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring) | resource |
| [google_project_iam_member.default_node](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.default_node](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [google_cloud_identity_group_lookup.registry_readers](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/cloud_identity_group_lookup) | data source |
| [google_container_engine_versions.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/container_engine_versions) | data source |
| [google_project.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_autoscaling"></a> [cluster\_autoscaling](#input\_cluster\_autoscaling) | Per-cluster configuration of node auto-provisioning with cluster autoscaler to automatically adjust the size of the cluster and create/delete node pools based on the current needs of the cluster's workload | <pre>object({<br/>    autoscaling_profile                      = optional(string, "OPTIMIZE_UTILIZATION")<br/>    disk_type                                = optional(string)<br/>    enabled                                  = optional(bool, false)<br/>    image_type                               = optional(string)<br/>    oauth_scopes                             = optional(list(string), ["https://www.googleapis.com/auth/cloud-platform"])<br/>    resource_limits_min_cpu_cores            = optional(number, 0)<br/>    resource_limits_min_memory_gb            = optional(number, 0)<br/>    resource_limits_max_cpu_cores            = optional(number, 6)<br/>    resource_limits_max_memory_gb            = optional(number, 32)<br/>    upgrade_settings_batch_node_count        = optional(number)<br/>    upgrade_settings_batch_percentage        = optional(number)<br/>    upgrade_settings_batch_soak_duration     = optional(string)<br/>    upgrade_settings_node_pool_soak_duration = optional(string)<br/>    upgrade_settings_max_surge               = optional(number)<br/>    upgrade_settings_max_unavailable         = optional(number, 1) # https://github.com/hashicorp/terraform-provider-google/issues/17164<br/>    upgrade_settings_strategy                = optional(string, "SURGE")<br/>  })</pre> | `{}` | no |
| <a name="input_cluster_prefix"></a> [cluster\_prefix](#input\_cluster\_prefix) | Prefix for your cluster name, region, and zone (if applicable) will be added to the end of the cluster name. Must be 20 characters or less | `string` | n/a | yes |
| <a name="input_cluster_secondary_range_name"></a> [cluster\_secondary\_range\_name](#input\_cluster\_secondary\_range\_name) | The name of the existing secondary range in the cluster's subnetwork to use for pod IP addresses | `string` | n/a | yes |
| <a name="input_daily_maintenance_window"></a> [daily\_maintenance\_window](#input\_daily\_maintenance\_window) | Time window specified for daily maintenance operations | `string` | `"06:00"` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | Whether or not to enable deletion protection on the cluster | `bool` | `true` | no |
| <a name="input_enable_gke_hub_host"></a> [enable\_gke\_hub\_host](#input\_enable\_gke\_hub\_host) | Whether or not to enable GKE Hub Host | `bool` | `false` | no |
| <a name="input_gke_hub_memberships"></a> [gke\_hub\_memberships](#input\_gke\_hub\_memberships) | The map of GKE Hub Memberships to create | <pre>map(object({<br/>    cluster_id = string<br/>  }))</pre> | `{}` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of key/value pairs to assign to the resources being created | `map(string)` | `{}` | no |
| <a name="input_master_ipv4_cidr_block"></a> [master\_ipv4\_cidr\_block](#input\_master\_ipv4\_cidr\_block) | The IP range in CIDR notation to use for the hosted master network | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | The name or self\_link of the Google Compute Engine network to which the cluster is connected | `string` | `"default"` | no |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | The node pools to create in the cluster | <pre>map(object({<br/>    auto_repair                              = optional(bool)<br/>    auto_upgrade                             = optional(bool)<br/>    disk_size_gb                             = optional(number)<br/>    disk_type                                = optional(string)<br/>    image_type                               = optional(string)<br/>    machine_type                             = optional(string)<br/>    max_node_count                           = optional(number, 3)<br/>    min_node_count                           = optional(number, 0)<br/>    node_count                               = optional(number)<br/>    oauth_scopes                             = optional(list(string), ["https://www.googleapis.com/auth/cloud-platform"])<br/>    upgrade_settings_batch_node_count        = optional(number)<br/>    upgrade_settings_batch_percentage        = optional(number)<br/>    upgrade_settings_batch_soak_duration     = optional(string)<br/>    upgrade_settings_node_pool_soak_duration = optional(string)<br/>    upgrade_settings_max_surge               = optional(number)<br/>    upgrade_settings_max_unavailable         = optional(number, 1) # https://github.com/hashicorp/terraform-provider-google/issues/17164<br/>    upgrade_settings_strategy                = optional(string, "SURGE")<br/>  }))</pre> | `{}` | no |
| <a name="input_project"></a> [project](#input\_project) | The ID of the project in which the resource belongs | `string` | n/a | yes |
| <a name="input_release_channel"></a> [release\_channel](#input\_release\_channel) | Configuration options for the Release channel feature, which provide more control over automatic upgrades of your GKE clusters | `string` | `"REGULAR"` | no |
| <a name="input_resource_labels"></a> [resource\_labels](#input\_resource\_labels) | The GCP labels (key/value pairs) to be applied to each node | `map(string)` | `{}` | no |
| <a name="input_services_secondary_range_name"></a> [services\_secondary\_range\_name](#input\_services\_secondary\_range\_name) | The name of the existing secondary range in the cluster's subnetwork to use for service | `string` | n/a | yes |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | The name or self\_link of the Google Compute Engine subnetwork in which the cluster's instances are launched | `string` | n/a | yes |
| <a name="input_vpc_host_project_id"></a> [vpc\_host\_project\_id](#input\_vpc\_host\_project\_id) | Host project for the shared VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_cluster_ca_certificate"></a> [container\_cluster\_ca\_certificate](#output\_container\_cluster\_ca\_certificate) | Base64 encoded public certificate that is the root of trust for the cluster |
| <a name="output_container_cluster_endpoint"></a> [container\_cluster\_endpoint](#output\_container\_cluster\_endpoint) | The connection endpoint for the cluster |
| <a name="output_container_cluster_id"></a> [container\_cluster\_id](#output\_container\_cluster\_id) | The unique identifier for the cluster |
| <a name="output_container_cluster_name"></a> [container\_cluster\_name](#output\_container\_cluster\_name) | The name of the cluster, unique within the project and location |
| <a name="output_kms_crypto_key_cluster_boot_disk_encryption_name"></a> [kms\_crypto\_key\_cluster\_boot\_disk\_encryption\_name](#output\_kms\_crypto\_key\_cluster\_boot\_disk\_encryption\_name) | The name of the Google Cloud KMS crypto key used to encrypt the boot disk |
| <a name="output_kms_crypto_key_cluster_database_encryption_name"></a> [kms\_crypto\_key\_cluster\_database\_encryption\_name](#output\_kms\_crypto\_key\_cluster\_database\_encryption\_name) | The name of the Google Cloud KMS crypto key used to encrypt the secrets |
| <a name="output_kms_key_ring_cluster_encryption_name"></a> [kms\_key\_ring\_cluster\_encryption\_name](#output\_kms\_key\_ring\_cluster\_encryption\_name) | The name of the Google Cloud KMS key ring |
| <a name="output_service_account_default_node_email"></a> [service\_account\_default\_node\_email](#output\_service\_account\_default\_node\_email) | The email address of the Kubernetes minimum privilege service account for the cluster |
<!-- END_TF_DOCS -->
