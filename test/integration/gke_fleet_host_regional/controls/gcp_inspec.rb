# Chef InSpec
# https://www.chef.io/inspec

# Since this is the default test, we want to test as much as possible here and not be redundant in
# the other tests.

container_cluster_prefix = 'fleet-host'
kms_crypto_key_cluster_database_encryption_name = \
  input('kms_crypto_key_cluster_database_encryption_name')
kms_key_ring_cluster_database_encryption_name = \
  input('kms_key_ring_cluster_database_encryption_name')
location = 'us-east1'
project_id = 'test-gke-fleet-host-tf64-sb'
service_account_gke_operations_email = input('service_account_gke_operations_email')

control 'container_cluster' do
  title 'Container Cluster'

  # Container Cluster Resource
  # https://docs.chef.io/inspec/resources/google_container_cluster

  describe google_container_cluster(project: project_id, location: location,
                                    name: "#{container_cluster_prefix}-#{location}") do
    it { should exist }
    its('network') { should eq 'kitchen-vpc' }
    its('private_cluster_config.enable_private_nodes') { should == true }
    its('status') { should eq 'RUNNING' }
    its('subnetwork') { should eq 'fleet-host-us-east1' }
  end
end

control 'container_node_pool' do
  title 'Container Node Pool'

  # Container Node Pool
  # https://docs.chef.io/inspec/resources/google_container_node_pool

  describe google_container_node_pool(project: project_id, location: location,
                                      cluster_name: "#{container_cluster_prefix}-#{location}",
                                      nodepool_name: 'default-pool') do
    it { should_not exist }
  end

  describe google_container_node_pool(project: project_id, location: location,
                                      cluster_name: "#{container_cluster_prefix}-#{location}",
                                      nodepool_name: 'standard-pool') do
    it { should exist }
    its('autoscaling.max_node_count') { should eq 3 }
    its('autoscaling.min_node_count') { should eq nil }
    its('config.disk_size_gb') { should eq 100 }
    its('config.disk_type') { should eq 'pd-balanced' }
    its('config.machine_type') { should eq 'g1-small' }
    its('config.oauth_scopes') { should include 'https://www.googleapis.com/auth/cloud-platform' }
    its('initial_node_count') { should eq nil }
  end
end

control 'kms_crypto_key' do
  title 'KMS Crypto Key'

  # KMS Crypto Key Resource
  # https://docs.chef.io/inspec/resources/google_kms_crypto_key

  describe google_kms_crypto_key(project: project_id, location: location,
                                 key_ring_name: kms_key_ring_cluster_database_encryption_name,
                                 name: kms_crypto_key_cluster_database_encryption_name) do
    it { should exist }
    its('primary_state') { should eq 'ENABLED' }
  end
end

control 'project_iam_binding' do
  title 'Project IAM Binding'

  # Project IAM Member Binding Resource
  # https://www.inspec.io/docs/reference/resources/google_project_iam_binding

  describe google_project_iam_binding(project: project_id,
                                      role: 'organizations/163313809793/roles/container.deployer') do
    it { should exist }
    its('members') do
      should include "serviceAccount:test-k8s-ns-admin@#{project_id}.iam.gserviceaccount.com"
    end
  end
end

control 'service_account' do
  title 'Service Account'

  # Service Account Resource
  # https://www.inspec.io/docs/reference/resources/google_service_account

  %w[test-k8s-ns-admin foo-k8s-wif bar-k8s-wif].each do |name|
    describe google_service_account(project: project_id,
                                    name: "#{name}@#{project_id}.iam.gserviceaccount.com") do
      it { should exist }
      its('email') { should eq "#{name}@#{project_id}.iam.gserviceaccount.com" }
    end
  end

  describe google_service_account(project: project_id,
                                  name: service_account_gke_operations_email) do
    it { should exist }
  end
end

control 'service_account_key' do
  title 'Service Account Key'

  # Service Account Key Resource
  # https://www.inspec.io/docs/reference/resources/google_service_account_key

  key_names = google_service_account_keys(project: project_id,
                                          service_account:
            "test-k8s-ns-admin@#{project_id}.iam.gserviceaccount.com").key_names

  key_names.each do |name|
    describe google_service_account_key(project: project_id,
                                        service_account: "test-k8s-ns-admin@#{project_id}.iam.gserviceaccount.com",
                                        name: name.split('/').last) do
      it { should exist }
    end
  end
end
