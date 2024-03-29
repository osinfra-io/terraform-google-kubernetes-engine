#! /usr/bin/env zsh

set -e

# Install the required gems
bundle install

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
    "gke-fleet-host-regional-onboarding-gcp" \
    "gke-fleet-host-regional-mci-gcp" \
    "gke-fleet-host-regional-istio-gcp" \
    "gke-fleet-member-global-gcp" \
    "gke-fleet-member-regional-gcp" \
    "gke-fleet-member-regional-onboarding-gcp" \
    "gke-fleet-member-regional-istio-gcp"

  # Enable the fleet membership for the member cluster

  export TF_VAR_gke_hub_memberships='{ "fleet-member-us-east1" = { cluster_id = "projects/test-gke-fleet-member-tfc5-sb/locations/us-east1/clusters/fleet-member-us-east1" } }'

  # Run converge on the gke-fleet-host-regional-gcp instance to enable the fleet membership
  bundle exec kitchen converge gke-fleet-host-regional-gcp

  # Run verify
  bundle exec kitchen verify
fi

# Run destroy on all instances sequentially
if [ "$1" = "-d" ]; then
  kitchen destroy \
    "gke-fleet-member-regional-istio-gcp" \
    "gke-fleet-host-regional-istio-gcp" \
    "gke-fleet-host-regional-mci-gcp" \
    "gke-fleet-member-regional-onboarding-gcp" \
    "gke-fleet-host-regional-onboarding-gcp" \
    "gke-fleet-member-regional-gcp" \
    "gke-fleet-member-global-gcp" \
    "gke-fleet-host-regional-gcp" \
    "gke-fleet-host-global-gcp"

  # Disable the fleet membership for the member cluster
  unset TF_VAR_gke_hub_memberships
fi
