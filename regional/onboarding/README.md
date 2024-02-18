# Terraform Documentation

> A child module automatically inherits default (un-aliased) provider configurations from its parent. The provider versions below are informational only and do **not** need to align with the provider configurations from its parent.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.15.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.25.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_namespace_v1.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |
| [kubernetes_role_binding_v1.namespace_admin](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding_v1) | resource |
| [kubernetes_role_v1.namespace_admin](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_v1) | resource |
| [kubernetes_service_account_v1.workload_identity](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account_v1) | resource |
| [google_service_account.namespace_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account) | data source |
| [google_service_account.workload_identity](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_google_service_account"></a> [google\_service\_account](#input\_google\_service\_account) | The optional email address of the pre-existing Google service account to use for the namespace administrator | `string` | `""` | no |
| <a name="input_namespace_admin"></a> [namespace\_admin](#input\_namespace\_admin) | The namespace administrator service account name, required if google\_service\_account is not set | `string` | `""` | no |
| <a name="input_namespaces"></a> [namespaces](#input\_namespaces) | A map of namespaces | <pre>map(object({<br>    istio_injection = optional(string, "disabled")<br>  }))</pre> | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project in which the resource belongs | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | The project ID |
| <a name="output_workload_identity_service_account_emails"></a> [workload\_identity\_service\_account\_emails](#output\_workload\_identity\_service\_account\_emails) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
