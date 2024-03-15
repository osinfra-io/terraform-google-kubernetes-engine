# Terraform Documentation

> A child module automatically inherits default (un-aliased) provider configurations from its parent. The provider versions below are informational only and do **not** need to align with the provider configurations from its parent.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.27.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.istio_gateway_mci](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.istio_gateway_mci_backendconfig](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.istio_gateway_mci_frontendconfig](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.istio_gateway_mcs](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_istio_gateway_mci_ip"></a> [istio\_gateway\_mci\_ip](#input\_istio\_gateway\_mci\_ip) | The IP address for the Istio Gateway multi-cluster ingress | `string` | `""` | no |
| <a name="input_multi_cluster_service_clusters"></a> [multi\_cluster\_service\_clusters](#input\_multi\_cluster\_service\_clusters) | List of clusters to be included in the MultiClusterService | <pre>list(object({<br>    link = string<br>  }))</pre> | `[]` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project in which the resource belongs | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
