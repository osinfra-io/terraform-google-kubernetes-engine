# Kubernetes Manifest Resource
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest

resource "kubernetes_manifest" "istio_gateway_mci" {
  manifest = {
    apiVersion = "networking.gke.io/v1"
    kind       = "MultiClusterIngress"

    metadata = {
      name      = "istio-gateway-mci"
      namespace = "istio-ingress"
      annotations = {
        "networking.gke.io/frontend-config"  = kubernetes_manifest.istio_gateway_mci_frontendconfig.manifest.metadata.name
        "networking.gke.io/pre-shared-certs" = "istio-gateway-mci"
        "networking.gke.io/static-ip"        = var.istio_gateway_mci_global_address
      }
    }

    spec = {
      template = {
        spec = {
          backend = {
            serviceName = kubernetes_manifest.istio_gateway_mcs.manifest.metadata.name
            servicePort = kubernetes_manifest.istio_gateway_mcs.manifest.spec.template.spec.ports[0].port
          }
          rules = [
            {
              http = {
                paths = [
                  {
                    backend = {
                      serviceName = kubernetes_manifest.istio_gateway_mcs.manifest.metadata.name
                      servicePort = kubernetes_manifest.istio_gateway_mcs.manifest.spec.template.spec.ports[0].port
                    }
                  }
                ]
              }
            }
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "istio_gateway_mci_backendconfig" {
  manifest = {
    apiVersion = "cloud.google.com/v1"
    kind       = "BackendConfig"
    metadata = {
      name      = "istio-gateway-mci-backend"
      namespace = "istio-ingress"
    }
    spec = {
      healthCheck = {
        checkIntervalSec   = "5"
        healthyThreshold   = "1"
        port               = "15021"
        requestPath        = "/healthz/ready"
        timeoutSec         = "3"
        type               = "HTTP"
        unhealthyThreshold = "2"
      }
    }
  }
}

resource "kubernetes_manifest" "istio_gateway_mci_frontendconfig" {
  manifest = {
    apiVersion = "networking.gke.io/v1beta1"
    kind       = "FrontendConfig"
    metadata = {
      name      = "istio-gateway-mci-frontend"
      namespace = "istio-ingress"
    }
    spec = {
      sslPolicy = "default"
      redirectToHttps = {
        enabled = true
      }
    }
  }
}

resource "kubernetes_manifest" "istio_gateway_mcs" {
  manifest = {
    apiVersion = "networking.gke.io/v1"
    kind       = "MultiClusterService"

    metadata = {
      name      = "istio-gateway-mcs"
      namespace = "istio-ingress"
      annotations = {
        "cloud.google.com/backend-config" = jsonencode({ "default" = "${kubernetes_manifest.istio_gateway_mci_backendconfig.manifest.metadata.name}" })
        "cloud.google.com/neg"            = jsonencode({ "ingress" = true })
        "networking.gke.io/app-protocols" = jsonencode({ "https" = "HTTPS" })
      }
    }

    spec = {
      template = {
        spec = {
          selector = {
            app   = "gateway"
            istio = "gateway"
          }

          ports = [
            {
              name       = "https"
              port       = 443
              protocol   = "TCP"
              targetPort = 443
            }
          ]
        }
      }

      clusters = var.multi_cluster_service_clusters
    }
  }
}
