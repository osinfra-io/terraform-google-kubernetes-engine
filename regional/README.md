# Terraform Documentation

A child module automatically inherits its parent's default (un-aliased) provider configurations. The provider versions below are informational only and do **not** need to align with the provider configurations from its parent.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.5.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 5.5.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_container_cluster.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_container_cluster) | resource |
| [google_container_node_pool.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool) | resource |
| [google_kms_crypto_key.cluster_database_encryption](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key) | resource |
| [google_kms_crypto_key_iam_member.cluster_database_encryption](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_member) | resource |
| [google_kms_key_ring.cluster_database_encryption](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring) | resource |
| [google_project_iam_member.gke_operations](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.gke_operations](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [google_container_engine_versions.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/container_engine_versions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_autoscaling"></a> [cluster\_autoscaling](#input\_cluster\_autoscaling) | Per-cluster configuration of node auto-provisioning with cluster autoscaler to automatically adjust the size of the cluster and create/delete node pools based on the current needs of the cluster's workload | <pre>object({<br>    auto_repair         = optional(bool)<br>    autoscaling_profile = optional(string, "OPTIMIZE_UTILIZATION")<br>    disk_type           = optional(string)<br>    enabled             = optional(bool, false)<br>    image_type          = optional(string)<br>    min_cpu_cores       = optional(number, 0)<br>    max_cpu_cores       = optional(number, 4)<br>    min_memory_gb       = optional(number, 0)<br>    max_memory_gb       = optional(number, 32)<br>    oauth_scopes        = optional(list(string), ["https://www.googleapis.com/auth/cloud-platform"])<br>  })</pre> | `{}` | no |
| <a name="input_cluster_prefix"></a> [cluster\_prefix](#input\_cluster\_prefix) | Prefix for your cluster name | `string` | n/a | yes |
| <a name="input_cluster_secondary_range_name"></a> [cluster\_secondary\_range\_name](#input\_cluster\_secondary\_range\_name) | The name of the existing secondary range in the cluster's subnetwork to use for pod IP addresses | `string` | n/a | yes |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | Whether or not to enable deletion protection on the cluster | `bool` | `true` | no |
| <a name="input_host_project_id"></a> [host\_project\_id](#input\_host\_project\_id) | Host project for the shared VPC | `string` | n/a | yes |
| <a name="input_kubernetes_daily_maintenance_window"></a> [kubernetes\_daily\_maintenance\_window](#input\_kubernetes\_daily\_maintenance\_window) | Time window specified for daily maintenance operations | `string` | `"06:00"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | The Kubernetes labels (key/value pairs) to be applied to each node | `map(string)` | `{}` | no |
| <a name="input_master_ipv4_cidr_block"></a> [master\_ipv4\_cidr\_block](#input\_master\_ipv4\_cidr\_block) | The IP range in CIDR notation to use for the hosted master network | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | The name or self\_link of the Google Compute Engine network to which the cluster is connected | `string` | `"default"` | no |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | List of maps containing node pools | <pre>map(object({<br>    auto_repair     = optional(bool)<br>    auto_upgrade    = optional(bool)<br>    disk_size_gb    = optional(number)<br>    disk_type       = optional(string)<br>    image_type      = optional(string)<br>    machine_type    = optional(string)<br>    max_node_count  = optional(number, 3)<br>    max_surge       = optional(number)<br>    max_unavailable = optional(number)<br>    min_node_count  = optional(number, 0)<br>    node_count      = optional(number)<br>    oauth_scopes    = optional(list(string), ["https://www.googleapis.com/auth/cloud-platform"])<br>    service_account = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project in which the resource belongs | `string` | n/a | yes |
| <a name="input_project_number"></a> [project\_number](#input\_project\_number) | The number of the project in which the resource belongs | `number` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region the cluster will run in if not creating a zonal cluster, required for subnet as well | `string` | `"us-east4"` | no |
| <a name="input_release_channel"></a> [release\_channel](#input\_release\_channel) | Configuration options for the Release channel feature, which provide more control over automatic upgrades of your GKE clusters | `string` | `"REGULAR"` | no |
| <a name="input_resource_labels"></a> [resource\_labels](#input\_resource\_labels) | The GCP labels (key/value pairs) to be applied to each node | `map(string)` | `{}` | no |
| <a name="input_services_secondary_range_name"></a> [services\_secondary\_range\_name](#input\_services\_secondary\_range\_name) | The name of the existing secondary range in the cluster's subnetwork to use for service | `string` | n/a | yes |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | The name or self\_link of the Google Compute Engine subnetwork in which the cluster's instances are launched | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_cluster_ca_certificate"></a> [container\_cluster\_ca\_certificate](#output\_container\_cluster\_ca\_certificate) | Base64 encoded public certificate that is the root of trust for the cluster |
| <a name="output_container_cluster_endpoint"></a> [container\_cluster\_endpoint](#output\_container\_cluster\_endpoint) | The connection endpoint for the cluster |
| <a name="output_container_cluster_id"></a> [container\_cluster\_id](#output\_container\_cluster\_id) | The unique identifier for the cluster |
| <a name="output_container_cluster_name"></a> [container\_cluster\_name](#output\_container\_cluster\_name) | The name of the cluster, unique within the project and location |
| <a name="output_kms_crypto_key_cluster_database_encryption_name"></a> [kms\_crypto\_key\_cluster\_database\_encryption\_name](#output\_kms\_crypto\_key\_cluster\_database\_encryption\_name) | The name of the Google Cloud KMS crypto key used to encrypt the secrets |
| <a name="output_service_account_gke_operations_email"></a> [service\_account\_gke\_operations\_email](#output\_service\_account\_gke\_operations\_email) | The email address of the Kubernetes minimum privilege service account for the cluster |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
