# Terraform Documentation

> A child module automatically inherits default (un-aliased) provider configurations from its parent. The provider versions below are informational only and do **not** need to align with the provider configurations from its parent.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.28.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_global_address.istio_gateway_mci](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_managed_ssl_certificate.istio_gateway_mci](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_managed_ssl_certificate) | resource |
| [google_compute_ssl_policy.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_ssl_policy) | resource |
| [google_dns_record_set.istio_gateway_mci](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [google_project_iam_member.container_deployer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.gke_hub_service_agent](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.host_project_network_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.multi_cluster_service_agent](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.service_project_network_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.kubernetes_workload_identity](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.workload_identity](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [google_project.fleet_host](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gke_fleet_host_project_id"></a> [gke\_fleet\_host\_project\_id](#input\_gke\_fleet\_host\_project\_id) | The project ID of the GKE Hub host project | `string` | `""` | no |
| <a name="input_istio_gateway_dns"></a> [istio\_gateway\_dns](#input\_istio\_gateway\_dns) | Map of attributes for the Istio gateway domain names, it is also used to create the managed certificate resource | <pre>map(object({<br>    managed_zone = string<br>    project      = string<br>  }))</pre> | `{}` | no |
| <a name="input_namespaces"></a> [namespaces](#input\_namespaces) | A map of namespaces with the Google service account used for the namespace administrator and whether Istio injection is enabled or disabled | <pre>map(object({<br>    google_service_account = string<br>    istio_injection        = optional(string, "disabled")<br>  }))</pre> | `{}` | no |
| <a name="input_project"></a> [project](#input\_project) | The ID of the project in which the resource belongs | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_deployer_service_accounts"></a> [container\_deployer\_service\_accounts](#output\_container\_deployer\_service\_accounts) | The service accounts for the container deployer |
| <a name="output_gke_fleet_host_project_number"></a> [gke\_fleet\_host\_project\_number](#output\_gke\_fleet\_host\_project\_number) | The project number of the fleet host project |
| <a name="output_istio_gateway_mci_global_address"></a> [istio\_gateway\_mci\_global\_address](#output\_istio\_gateway\_mci\_global\_address) | The IP address for the Istio Gateway multi-cluster ingress |
| <a name="output_istio_gateway_mci_ssl_certificate_name"></a> [istio\_gateway\_mci\_ssl\_certificate\_name](#output\_istio\_gateway\_mci\_ssl\_certificate\_name) | The name of the SSL certificate for the Istio Gateway multi-cluster ingress |
| <a name="output_workload_identity_service_account_emails"></a> [workload\_identity\_service\_account\_emails](#output\_workload\_identity\_service\_account\_emails) | The email addresses of the service accounts for the Kubernetes namespace workload identity |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
