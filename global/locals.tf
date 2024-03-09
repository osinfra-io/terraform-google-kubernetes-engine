# Local Values
# https://www.terraform.io/docs/language/values/locals.html


locals {
  istio_gateway_domains = keys(var.mci_istio_gateway_dns)
}
