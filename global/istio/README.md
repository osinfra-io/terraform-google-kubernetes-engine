# Terraform Documentation

> A child module automatically inherits default (un-aliased) provider configurations from its parent. The provider versions below are informational only and do **not** need to align with the provider configurations from its parent.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.18.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_managed_ssl_certificate.istio_mci_gateway](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_managed_ssl_certificate) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_istio_gateway_ssl"></a> [istio\_gateway\_ssl](#input\_istio\_gateway\_ssl) | List of domain names for the Istio gateway SSL SAN certificate | `list(string)` | `[]` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project in which the resource belongs | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_istio_mci_gateway_ssl_name"></a> [istio\_mci\_gateway\_ssl\_name](#output\_istio\_mci\_gateway\_ssl\_name) | The Google Compute Managed SSL Certificate resource name for the Istio MultiClusterIngress Gateway |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
