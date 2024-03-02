# Google Compute Global Address Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address

resource "google_compute_global_address" "istio_gateway" {
  count = var.enable_istio_gateway ? 1 : 0


  name    = "istio-gateway-${var.region}"
  project = var.project_id
}

# DNS Record Set Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set

resource "google_dns_record_set" "istio_gateway" {
  for_each = var.istio_gateway_dns

  managed_zone = each.value.managed_zone
  name         = "${each.key}."
  project      = each.value.project
  rrdatas      = [google_compute_global_address.istio_gateway[0].address]
  ttl          = 300
  type         = "A"
}

# Helm Release
# https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release

resource "helm_release" "istio_base" {
  chart      = "base"
  name       = "istio-base"
  namespace  = "istio-system"
  repository = var.istio_chart_repository

  values = [
    file("${path.module}/helm/istio-base.yml")
  ]

  version = var.istio_version
}

resource "helm_release" "istiod" {
  chart      = "istiod"
  name       = "istiod"
  namespace  = "istio-system"
  repository = var.istio_chart_repository

  set {
    name  = "global.hub"
    value = "${var.artifact_registry}/istio"
  }

  set {
    name  = "global.multiCluster.clusterName"
    value = local.multi_cluster_name
  }

  set {
    name  = "pilot.autoscaleMin"
    value = var.pilot_autoscale_min
  }

  set {
    name  = "pilot.podLabels.tags\\.datadoghq\\.com/env"
    value = var.environment
  }

  set {
    name  = "pilot.podLabels.tags\\.datadoghq\\.com/version"
    value = var.istio_version
  }

  values = [
    file("${path.module}/helm/istiod.yml")
  ]

  version = var.istio_version

  depends_on = [
    helm_release.istio_base
  ]
}

resource "helm_release" "gateway" {
  count = var.enable_istio_gateway ? 1 : 0

  chart      = "gateway"
  name       = "gateway"
  namespace  = "istio-ingress"
  repository = var.istio_chart_repository

  set {
    name  = "autoscaling.minReplicas"
    value = var.gateway_autoscale_min
  }

  set {
    name  = "labels.tags\\.datadoghq\\.com/env"
    value = var.environment
  }

  set {
    name  = "labels.tags\\.datadoghq\\.com/service"
    value = "istio-gateway"
  }

  set {
    name  = "labels.tags\\.datadoghq\\.com/source"
    value = "envoy"
  }

  set {
    name  = "labels.tags\\.datadoghq\\.com/version"
    value = var.istio_version
  }

  set {
    name  = "podAnnotations.apm\\.datadoghq\\.com/env"
    value = local.istio_gateway_datadog_apm_env
  }

  values = [
    file("${path.module}/helm/gateway.yml")
  ]

  version = var.istio_version

  depends_on = [
    helm_release.istiod
  ]
}

# Kubernetes Ingress Resource
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1

resource "kubernetes_ingress_v1" "istio_gateway" {
  count = var.enable_istio_gateway ? 1 : 0

  metadata {
    name      = "istio-gateway"
    namespace = "istio-ingress"

    annotations = {
      "kubernetes.io/ingress.allow-http"            = "false"
      "kubernetes.io/ingress.global-static-ip-name" = google_compute_global_address.istio_gateway[0].name
      "networking.gke.io/v1beta1.FrontendConfig"    = kubernetes_manifest.istio_gateway_frontendconfig[0].manifest.metadata.name
      "networking.gke.io/managed-certificates"      = kubernetes_manifest.istio_gateway_managed_certificate[0].manifest.metadata.name
    }
  }
  spec {
    rule {
      http {
        path {
          backend {
            service {
              name = "gateway"
              port {
                number = 443
              }
            }
          }
        }
      }
    }
  }

  wait_for_load_balancer = true

  depends_on = [
    helm_release.gateway
  ]
}


# Kubernetes Manifest Resource
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest

resource "kubernetes_manifest" "istio_gateway_backendconfig" {
  count = var.enable_istio_gateway ? 1 : 0

  manifest = {
    "apiVersion" = "cloud.google.com/v1"
    "kind"       = "BackendConfig"
    "metadata" = {
      "name"      = "istio-gateway-backend"
      "namespace" = "istio-ingress"
    }
    "spec" = {
      "healthCheck" = {
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

resource "kubernetes_manifest" "istio_gateway_frontendconfig" {
  count = var.enable_istio_gateway ? 1 : 0

  manifest = {
    "apiVersion" = "networking.gke.io/v1beta1"
    "kind"       = "FrontendConfig"
    "metadata" = {
      "name"      = "istio-gateway-frontend"
      "namespace" = "istio-ingress"
    }
    "spec" = {
      "sslPolicy" = "default"
      "redirectToHttps" = {
        "enabled" = true
      }
    }
  }
}

resource "kubernetes_manifest" "istio_gateway_managed_certificate" {
  count = var.enable_istio_gateway ? 1 : 0

  manifest = {
    "apiVersion" = "networking.gke.io/v1"
    "kind"       = "ManagedCertificate"
    "metadata" = {
      "name"      = "istio-gateway-tls"
      "namespace" = "istio-ingress"
    }
    "spec" = {
      "domains" = var.istio_gateway_ssl
    }
  }
}
