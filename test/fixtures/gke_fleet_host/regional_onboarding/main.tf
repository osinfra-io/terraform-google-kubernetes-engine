# Kubernetes Provider
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest

provider "kubernetes" {
  cluster_ca_certificate = base64decode(
    local.regional.cluster_ca_certificate
  )

  host  = "https://${local.regional.cluster_endpoint}"
  token = data.google_client_config.current.access_token
}

# Google Client Config Data Source
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config

data "google_client_config" "current" {
}

# Remote State Data Source
# https://www.terraform.io/language/state/remote-state-data

# This is the preferred way to get the remote state data from other terraform workspaces and how we recommend
# you do it in your root module.

data "terraform_remote_state" "global" {
  backend   = "gcs"
  workspace = "kitchen-terraform-gke-fleet-host-global-gcp"

  config = {
    bucket = "plt-lz-testing-2c8b-sb"
  }
}

data "terraform_remote_state" "regional" {
  backend   = "gcs"
  workspace = "kitchen-terraform-gke-fleet-host-regional-gcp"

  config = {
    bucket = "plt-lz-testing-2c8b-sb"
  }
}

module "test" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test.
  # source = "git@github.com:osinfra-io/terraform-google-kubernetes-engine//regional/onboarding?ref=v0.0.0"

  source = "../../../../regional/onboarding"

  google_service_account = "plt-lz-testing-github@ptl-lz-terraform-tf91-sb.iam.gserviceaccount.com"

  namespaces = {

    bar = {
      istio_injection = "disabled"
    }

    foo = {
      istio_injection = "enabled"
    }

    istio-ingress = {
      istio_injection = "enabled"
    }

    istio-system = {}
  }

  project_id = var.project_id

  workload_identity_service_account_emails = data.terraform_remote_state.global.outputs.workload_identity_service_account_emails
}

# This is a test to validate workload identity. It's not needed for the module to work.
# This test is loosely based on:
# https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity#verify_the_setup

resource "kubernetes_job_v1" "test" {
  for_each = toset(
    [
      "foo",
      "bar"
    ]
  )

  metadata {
    name      = "workload-identity-test"
    namespace = each.key
  }

  spec {
    template {
      metadata {}
      spec {
        container {
          image = "google/cloud-sdk:slim"
          name  = "workload-identity-test"

          # If the service accounts are correctly configured, the IAM service account email address is listed as the active (and only) identity.
          # This demonstrates that by default, the Pod acts as the IAM service account's authority when calling Google Cloud APIs.

          command = [
            "/bin/bash", "-c", "curl -H 'Metadata-Flavor: Google' http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/email | grep ${data.terraform_remote_state.global.outputs.workload_identity_service_account_emails[each.key]}", "[ $? -ne 0 ] || exit 1"
          ]

        }

        restart_policy       = "Never"
        service_account_name = "${each.key}-workload-identity-sa"
      }
    }

    # Fast developer feedback is important so we set the backoff limit to 1.

    backoff_limit = 1
  }

  wait_for_completion = true

  timeouts {
    create = "5m"
    update = "5m"
  }

  depends_on = [
    module.test
  ]
}
