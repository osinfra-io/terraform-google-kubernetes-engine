# Terraform Documentation

> A child module automatically inherits default (un-aliased) provider configurations from its parent. The provider versions below are informational only and do **not** need to align with the provider configurations from its parent.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project_iam_member.container_deployer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.kubernetes_namespace_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.kubernetes_workload_identity](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.workload_identity](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_key.kubernetes_namespace_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_google_service_account"></a> [google\_service\_account](#input\_google\_service\_account) | The optional email address of the pre-existing Google service account to use for the namespace administrator | `string` | `""` | no |
| <a name="input_namespace_admin"></a> [namespace\_admin](#input\_namespace\_admin) | The namespace administrator service account name, required if google\_service\_account is not set | `string` | `""` | no |
| <a name="input_namespaces"></a> [namespaces](#input\_namespaces) | A map of namespaces | <pre>map(object({<br>    istio_injection = optional(string, "disabled")<br>  }))</pre> | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project in which the resource belongs | `string` | n/a | yes |
| <a name="input_vpc_host_project_id"></a> [vpc\_host\_project\_id](#input\_vpc\_host\_project\_id) | The project ID and number of the GKE Hub host project | <pre>map(object({<br>    project_number = string<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kubernetes_namespace_admin_key"></a> [kubernetes\_namespace\_admin\_key](#output\_kubernetes\_namespace\_admin\_key) | n/a |
| <a name="output_workload_identity_service_account_emails"></a> [workload\_identity\_service\_account\_emails](#output\_workload\_identity\_service\_account\_emails) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
