# Chef InSpec
# https://www.chef.io/inspec

container_deployer_service_accounts = input('container_deployer_service_accounts')
project_id = input('project_id')

control 'compute_global_address' do
  title 'Compute Global Address'

  # Compute Global Address Resource
  # https://www.inspec.io/docs/reference/resources/google_compute_global_address

  describe google_compute_global_address(project: project_id, name: 'istio-gateway-mci') do
    it { should exist }
    its('address_type') { should eq 'EXTERNAL' }
  end
end

control 'compute_ssl_certificate' do
  title 'Compute SSL Certificate'

  # Compute SSL Certificate Resource
  # https://www.inspec.io/docs/reference/resources/google_compute_ssl_certificate

  describe google_compute_ssl_certificate(project: project_id, name: 'istio-gateway-mci') do
    it { should exist }
  end
end

control 'compute_ssl_policy' do
  title 'Compute SSL Policy'

  # Compute SSL Policy Resource
  # https://www.inspec.io/docs/reference/resources/google_compute_ssl_policy

  describe google_compute_ssl_policy(project: project_id, name: 'default') do
    it { should exist }
  end
end

control 'dns_resource_record_set' do
  title 'DNS Record Set'

  # DNS Resource Record Set Resource
  # https://www.inspec.io/docs/reference/resources/google_dns_resource_record_set

  ['gateway.test.gcp.osinfra.io', 'stream-team.test.gcp.osinfra.io'].each do |record|
    describe google_dns_resource_record_set(project: 'test-default-tf75-sb', managed_zone: 'test-gcp-osinfra-io',
                                            name: "#{record}.", type: 'A') do
      it { should exist }
      its('type') { should eq 'A' }
    end
  end
end

control 'project_iam_binding' do
  title 'Project IAM Binding'

  # Project IAM Member Binding Resource
  # https://www.inspec.io/docs/reference/resources/google_project_iam_binding

  describe google_project_iam_binding(project: project_id, role: 'roles/compute.networkViewer') do
    it { should exist }
    its('members') do
      should include "serviceAccount:#{project_id}.svc.id.goog[gke-mcs/gke-mcs-importer]"
    end
  end

  container_deployer_service_accounts.each do |service_account|
    describe google_project_iam_binding(project: project_id,
                                        role: 'organizations/163313809793/roles/container.deployer') do
      it { should exist }
      its('members') { should include "serviceAccount:#{service_account}" }
    end
  end
end
