# Google Compute Managed SSL Certificate Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_managed_ssl_certificate

# The declarative generation of a Kubernetes ManagedCertificate resource is not supported on
# MultiClusterIngress resources.

# These resources will need to be versioned since they will be in use by the MultiClusterIngress resources.

# Stream aligned team domains will always use Subject Alternative Names
# Ingress can only support 10 SSL certificates so we use a single
# certificate with up to 100 Subject Alternative Names.

resource "google_compute_managed_ssl_certificate" "istio_mci_gateway" {
  count = var.istio_gateway_ssl != [] ? 1 : 0

  managed {
    domains = var.istio_gateway_ssl
  }

  name    = "istio-mci-gateway"
  project = var.project_id
}
