# Terraform Documentation

> A child module automatically inherits default (un-aliased) provider configurations from its parent. The provider versions below are informational only and do **not** need to align with the provider configurations from its parent.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.20.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.12.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.27.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_global_address.istio_gateway](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_dns_record_set.istio_gateway](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [helm_release.gateway](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.istio_base](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.istiod](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_ingress_v1.istio_gateway](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_manifest.istio_gateway_backendconfig](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.istio_gateway_frontendconfig](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.istio_gateway_managed_certificate](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_artifact_registry"></a> [artifact\_registry](#input\_artifact\_registry) | The registry to pull the images from | `string` | `"us-docker.pkg.dev/plt-lz-services-tf79-prod/platform-docker-virtual"` | no |
| <a name="input_cluster_prefix"></a> [cluster\_prefix](#input\_cluster\_prefix) | Prefix for your cluster name | `string` | n/a | yes |
| <a name="input_enable_istio_gateway"></a> [enable\_istio\_gateway](#input\_enable\_istio\_gateway) | Enable the Istio gateway, used for ingress traffic into the mesh | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment suffix for example: `sb` (Sandbox), `nonprod` (Non-Production), `prod` (Production) | `string` | `"sb"` | no |
| <a name="input_gateway_autoscale_min"></a> [gateway\_autoscale\_min](#input\_gateway\_autoscale\_min) | The minimum number of gateway replicas to run | `number` | `1` | no |
| <a name="input_ingress_istio_gateway_dns"></a> [ingress\_istio\_gateway\_dns](#input\_ingress\_istio\_gateway\_dns) | Map of attributes for the ingress Istio gateway domain names, it is also used to create the managed certificate resource | <pre>map(object({<br>    managed_zone = string<br>    project      = string<br>  }))</pre> | `{}` | no |
| <a name="input_istio_chart_repository"></a> [istio\_chart\_repository](#input\_istio\_chart\_repository) | The repository to pull the Istio Helm chart from | `string` | `"https://istio-release.storage.googleapis.com/charts"` | no |
| <a name="input_istio_version"></a> [istio\_version](#input\_istio\_version) | The version of istio to install | `string` | `"1.20.3"` | no |
| <a name="input_pilot_autoscale_min"></a> [pilot\_autoscale\_min](#input\_pilot\_autoscale\_min) | The minimum number of pilot replicas to run | `number` | `1` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project in which the resource belongs | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to deploy the resources into | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_istio_gateway_ip"></a> [istio\_gateway\_ip](#output\_istio\_gateway\_ip) | The IP address of the Istio Gateway |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
