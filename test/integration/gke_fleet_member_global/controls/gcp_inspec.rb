# Chef InSpec
# https://www.chef.io/inspec

gke_fleet_host_project_id = input('gke_fleet_host_project_id')
gke_fleet_host_project_number = input('gke_fleet_host_project_number')
project_id = input('project_id')

control 'project_iam_binding' do
  title 'Project IAM Binding'

  # Project IAM Member Binding Resource
  # https://www.inspec.io/docs/reference/resources/google_project_iam_binding

  def check_iam_binding(project_id, role, service_account)
    describe google_project_iam_binding(project: project_id, role: role) do
      it { should exist }
      its('members') { should include service_account }
    end
  end

  check_iam_binding(project_id, 'roles/gkehub.serviceAgent',
                    "serviceAccount:service-#{gke_fleet_host_project_number}@gcp-sa-gkehub.iam.gserviceaccount.com")
  check_iam_binding(project_id, 'roles/multiclusterservicediscovery.serviceAgent',
                    "serviceAccount:service-#{gke_fleet_host_project_number}@gcp-sa-mcsd.iam.gserviceaccount.com")
  check_iam_binding(project_id, 'roles/compute.networkViewer',
                    "serviceAccount:#{gke_fleet_host_project_id}.svc.id.goog[gke-mcs/gke-mcs-importer]")
end
