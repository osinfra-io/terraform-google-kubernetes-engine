mock_provider "google" {
  mock_resource "google_service_account" {
    defaults = {
      name  = "projects/mock/serviceAccounts/gke-tf777641-workload-identity@mock.iam.gserviceaccount.com"
      email = "gke-tf777641-workload-identity@mock.iam.gserviceaccount.com"
    }
  }
}

mock_provider "google-beta" {}
mock_provider "helm" {}
mock_provider "kubernetes" {}

mock_provider "terraform" {
  mock_data "terraform_remote_state" {
    defaults = {
      outputs = {
        istio_gateway_mci_global_address = "35.184.145.227"
        workload_identity_service_account_emails = {
          gke-go-example   = "gke-tf111111-workload-identity@mock.iam.gserviceaccount.com"
          gke-java-example = "gke-tf222222-workload-identity@mock.iam.gserviceaccount.com"
          istio-ingress    = "gke-tf333333-workload-identity@mock.iam.gserviceaccount.com"
          istio-system     = "gke-tf444444-workload-identity@mock.iam.gserviceaccount.com"
        }
      }
    }
  }
}

run "gke_fleet_host_global" {
  command = apply

  module {
    source = "./tests/fixtures/gke_fleet_host"
  }
}

run "gke_fleet_host_regional" {
  command = apply

  module {
    source = "./tests/fixtures/gke_fleet_host/regional"
  }
}

run "gke_fleet_host_regional_onboarding" {
  command = apply

  module {
    source = "./tests/fixtures/gke_fleet_host/regional_onboarding"
  }
}


run "gke_fleet_host_regional_mci" {
  command = apply

  module {
    source = "./tests/fixtures/gke_fleet_host/regional_mci"
  }
}

run "gke_fleet_host_regional_istio" {
  command = apply

  module {
    source = "./tests/fixtures/gke_fleet_host/regional_istio"
  }
}

run "gke_fleet_member_global" {
  command = apply

  module {
    source = "./tests/fixtures/gke_fleet_member"
  }
}

run "gke_fleet_member_regional" {
  command = apply

  module {
    source = "./tests/fixtures/gke_fleet_member/regional"
  }
}

run "gke_fleet_member_regional_onboarding" {
  command = apply

  module {
    source = "./tests/fixtures/gke_fleet_member/regional_onboarding"
  }
}

run "gke_fleet_member_regional_istio" {
  command = apply

  module {
    source = "./tests/fixtures/gke_fleet_member/regional_istio"
  }
}

run "gke_fleet_host_regional_hub_membership" {
  command = apply

  module {
    source = "./tests/fixtures/gke_fleet_host/regional"
  }

  variables {
    gke_hub_memberships = { "fleet-member-us-east1" = { cluster_id = "projects/test-gke-fleet-member-tfc5-sb/locations/us-east1/clusters/fleet-member-us-east1" } }
  }
}
