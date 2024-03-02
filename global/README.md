# Terraform Documentation

> A child module automatically inherits default (un-aliased) provider configurations from its parent. The provider versions below are informational only and do **not** need to align with the provider configurations from its parent.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.16.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_ssl_policy.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_ssl_policy) | resource |
| [google_project_iam_member.gke_hub_service_agent](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.host_project_network_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.multi_cluster_service_agent](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.service_project_network_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project.fleet_host](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gke_fleet_host_project_id"></a> [gke\_fleet\_host\_project\_id](#input\_gke\_fleet\_host\_project\_id) | The project ID of the GKE Hub host project | `string` | `null` | no |
| <a name="input_istio_gateway_ssl"></a> [istio\_gateway\_ssl](#input\_istio\_gateway\_ssl) | List of domain names for the Istio gateway SSL SAN certificate | `list(string)` | `[]` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project in which the resource belongs | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gke_fleet_host_project_number"></a> [gke\_fleet\_host\_project\_number](#output\_gke\_fleet\_host\_project\_number) | The project number of the fleet host project |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
