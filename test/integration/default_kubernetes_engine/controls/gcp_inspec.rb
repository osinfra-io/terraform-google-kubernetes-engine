# Chef InSpec
# https://www.chef.io/inspec

# Since this is the default test, we want to test as much as possible here and not be redundant in the other tests.

cluster_name = input('cluster_name')
service_account_gke_operations_email = input('service_account_gke_operations_email')
location = input('location')
project_id = input('project_id')

control 'container_cluster' do
  title 'Container Cluster'

  # Container Cluster Resource
  # https://docs.chef.io/inspec/resources/google_container_cluster

  describe google_container_cluster(project: project_id, location: location, name: cluster_name) do
    it { should exist }
    its('network') { should eq 'kitchen-vpc' }
    its('private_cluster_config.enable_private_nodes') { should == true }
    its('status') { should eq 'RUNNING' }
    its('subnetwork') { should eq 'kitchen-subnet-us-east1' }
  end
end

control 'container_node_pool' do
  title 'Container Node Pool'

  # Container Node Pool
  # https://docs.chef.io/inspec/resources/google_container_node_pool

  describe google_container_node_pool(project: project_id, location: location, cluster_name: cluster_name,
                                      nodepool_name: 'default-pool') do
    it { should_not exist }
  end

  describe google_container_node_pool(project: project_id, location: location, cluster_name: cluster_name,
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

  describe google_kms_crypto_key(project: project_id, location: location, key_ring_name: 'kitchen-key-ring',
                                 name: 'kitchen-crypto-key') do
    it { should exist }
    its('primary_state') { should eq 'ENABLED' }
  end
end

control 'project_iam_binding' do
  title 'Project IAM Binding'

  # Project IAM Binding Resource
  # https://docs.chef.io/inspec/resources/google_project_iam_binding

  describe google_project_iam_binding(project: project_id,
                                      role: 'organizations/938022021827/roles/compute_security_k8s') do
    it { should exist }
    its('members') do
      should include 'serviceAccount:service-486128476137@container-engine-robot.iam.gserviceaccount.com'
    end
  end
end
