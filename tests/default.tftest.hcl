// Most of these tests need to run sequentially since they have dependencies on each other. However a couple could
// be run in parallel if that was supported (https://github.com/hashicorp/terraform/issues/34180).
// The tests that can run in parallel have comments indicating that.

// Without remote state support, this sort of test is simply not feasible. The feedback loop is too slow
// if a test fails (https://github.com/hashicorp/terraform/issues/34073).

// TODO: Re-uasable assertions. This is not supported in the current version of the testing framework.
// https://github.com/hashicorp/terraform/issues/34980

run "gke_fleet_host_global" {
  command = apply

  module {
    source = "./tests/fixtures/gke_fleet_host/global"
  }
}

run "gke_fleet_host_regional" {
  command = apply

  module {
    source = "./tests/fixtures/gke_fleet_host/regional"
  }
}

// This test can't run unless if can access the state of the previous test to get the cluster information
// for the kubernetes provider.

// run "gke_fleet_host_regional_onboarding" {
//   command = apply

//   module {
//     source = "./tests/fixtures/gke_fleet_host/regional_onboarding"
//   }
// }

// This test needs to be re-run after gke_fleet_member_regional tests runs since we need the cluster_id from that test.
// This is not feasible without remote state support either.

// This test can't run unless if can access the state of the previous test to get the cluster information
// for the kubernetes provider.

// run "gke_fleet_host_regional_mci" { # Parallel
//   command = apply

//   module {
//     source = "./tests/fixtures/gke_fleet_host/regional_mci"
//   }
// }

// This test can't run unless if can access the state of the previous test to get the cluster information
// for the kubernetes provider.

// run "gke_fleet_host_regional_istio" { # Parallel
//   command = apply

//   module {
//     source = "./tests/fixtures/gke_fleet_host/regional_istio"
//   }
// }

// This test runs bu is redundant since we can't run the other associated tests due to lack of remote state support.

// run "gke_fleet_member_global" {
//   command = apply

//   module {
//     source = "./tests/fixtures/gke_fleet_member/global"
//   }
// }

// run "gke_fleet_member_regional" {
//   command = apply

//   module {
//     source = "./tests/fixtures/gke_fleet_member/regional"
//   }
// }

// This test can't run unless if can access the state of the previous test to get the cluster information
// for the kubernetes provider.

// run "gke_fleet_member_regional_onboarding" {
//   command = apply

//   module {
//     source = "./tests/fixtures/gke_fleet_member/regional_onboarding"
//   }
// }

// This test can't run unless if can access the state of the previous test to get the cluster information
// for the kubernetes provider.

// run "gke_fleet_member_regional_istio" {
//   command = apply

//   module {
//     source = "./tests/fixtures/gke_fleet_member/regional_istio"
//   }
// }

// Duplicate "run" block names not supported, no remote state. Ideaaly this test would pick up
// from the pre-existing state of the other run block.

// run "gke_fleet_host_regional" {
//   command = apply

//   module {
//     source = "./tests/fixtures/gke_fleet_host/regional"
//   }

//   // We need the cluster_id from the gke_fleet_member_regional test in order to create the hub membership.

//   variables {
//     gke_hub_memberships = { "fleet-member-us-east1" = { cluster_id = "projects/test-gke-fleet-member-tfc5-sb/locations/us-east1/clusters/fleet-member-us-east1" } }
//   }
// }
