# Chef InSpec
# https://www.chef.io/inspec

project_id = input('project_id')

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
end
