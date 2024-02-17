#! /usr/bin/env zsh

set -e

# Run converge on all instances sequentially

instances=(
  "gke-fleet-host-global-gcp"
  "gke-fleet-host-regional-gcp"
  "gke-fleet-host-global-onboarding-gcp"
  "gke-fleet-host-regional-onboarding-gcp"
  "gke-fleet-member-global-gcp"
  "gke-fleet-member-regional-gcp"
)

for instance in ${instances}; do
  bundle exec kitchen converge $instance
done

# Uncomment the fleet membership for the member cluster

sed -i '/### START GKE HUB MEMBERSHIPS ###/,/### END GKE HUB MEMBERSHIPS ###/{//!s/^\s*#//}' test/fixtures/gke_fleet_host/regional/main.tf

# Run converge on the gke-fleet-host-regional-gcp instance to enable the fleet membership

bundle exec kitchen converge gke-fleet-host-regional-gcp

# Run verify

bundle exec kitchen verify
