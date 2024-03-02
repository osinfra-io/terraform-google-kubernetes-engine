#! /usr/bin/env zsh

set -e

# Define a function to run a kitchen command on multiple instances
kitchen() {
  local command=$1
  shift
  local instances=("$@")

  for instance in "${instances[@]}"; do
    bundle exec kitchen $command $instance
  done
}

# Run converge on all instances sequentially
if [ ! $1 ]; then
  kitchen converge \
    "gke-fleet-host-global-gcp" \
    "gke-fleet-host-regional-gcp" \
    "gke-fleet-host-global-onboarding-gcp" \
    "gke-fleet-host-regional-onboarding-gcp" \
    "gke-fleet-host-regional-istio-gcp" \
    "gke-fleet-member-global-gcp" \
    "gke-fleet-member-regional-gcp"

  # Uncomment the fleet membership for the member cluster
  sed -i '/### START GKE HUB MEMBERSHIPS ###/,/### END GKE HUB MEMBERSHIPS ###/{//!s/^\s*#//}' test/fixtures/gke_fleet_host/regional/main.tf

  # Run converge on the gke-fleet-host-regional-gcp instance to enable the fleet membership
  bundle exec kitchen converge gke-fleet-host-regional-gcp

  # Run verify
  bundle exec kitchen verify
fi

# Run destroy on all instances sequentially
if [ "$1" = "-d" ]; then
  kitchen destroy \
    "gke-fleet-host-regional-istio-gcp" \
    "gke-fleet-host-regional-onboarding-gcp" \
    "gke-fleet-host-global-onboarding-gcp" \
    "gke-fleet-member-regional-gcp" \
    "gke-fleet-member-global-gcp" \
    "gke-fleet-host-regional-gcp" \
    "gke-fleet-host-global-gcp"

# Comment the fleet membership for the member cluster
  sed -i '/### START GKE HUB MEMBERSHIPS ###/,/### END GKE HUB MEMBERSHIPS ###/{//!s/^/  #/}' test/fixtures/gke_fleet_host/regional/main.tf
fi
