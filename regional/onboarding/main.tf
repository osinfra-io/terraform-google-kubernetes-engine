# Google Service Account Data Source
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account

data "google_service_account" "workload_identity" {
  for_each = var.namespaces

  account_id = var.workload_identity_service_account_emails[each.key]
}

# Kubernetes Namespace Resource
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1

resource "kubernetes_namespace_v1" "this" {
  for_each = merge(
    var.namespaces,
    {
      "cert-manager"  = {},
      "datadog"       = {},
      "istio-ingress" = { istio_injection = "enabled" },
      "istio-system"  = {}
    }
  )

  metadata {
    labels = {
      "istio-injection" = each.value.istio_injection
    }

    name = each.key
  }
}


# Kubernetes Role Resource
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_v1

resource "kubernetes_role_v1" "namespace_admin" {

  # Minimize wildcard use in Roles and ClusterRoles
  # https://github.com/osinfra-io/terraform-google-kubernetes-engine/issues/76
  # checkov:skip=CKV_K8S_49

  for_each = var.namespaces

  metadata {
    name      = "namespace-admin"
    namespace = kubernetes_namespace_v1.this[each.key].metadata.0.name
  }

  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["create", "delete", "get", "list", "patch", "update", "watch"]
  }
}

# Kubernetes Role Binding Resource
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding_v1

resource "kubernetes_role_binding_v1" "namespace_admin" {
  for_each = local.namespace_admin_service_accounts

  metadata {
    name      = "namespace-admin"
    namespace = kubernetes_namespace_v1.this[each.value.namespace].metadata.0.name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "namespace-admin"
  }

  subject {
    kind = "User"
    name = each.value.service_account
  }
}

# Kubernetes Service Account Resource
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account_v1

resource "kubernetes_service_account_v1" "workload_identity" {
  for_each = var.namespaces

  metadata {

    annotations = {
      "iam.gke.io/gcp-service-account" = data.google_service_account.workload_identity[each.key].email
    }

    name      = "${each.key}-workload-identity-sa"
    namespace = kubernetes_namespace_v1.this[each.key].metadata.0.name
  }
}
