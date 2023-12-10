# <img align="left" width="45" height="45" src="https://github.com/osinfra-io/terraform-google-kubernetes-engine/assets/1610100/38c94ec5-3cef-4716-9744-791d4df598ba"> Google Cloud Platform - Kubernetes Engine Terraform Module

**[GitHub Actions](https://github.com/osinfra-io/terraform-google-kubernetes-engine/actions):**

[![Kitchen Tests](https://github.com/osinfra-io/terraform-google-kubernetes-engine/actions/workflows/kitchen.yml/badge.svg)](https://github.com/osinfra-io/terraform-google-kubernetes-engine/actions/workflows/kitchen.yml) [![CodeQL](https://github.com/osinfra-io/terraform-google-kubernetes-engine/actions/workflows/github-code-scanning/codeql/badge.svg)](https://github.com/osinfra-io/terraform-google-kubernetes-engine/actions/workflows/github-code-scanning/codeql) [![Dependabot](https://github.com/osinfra-io/terraform-google-kubernetes-engine/actions/workflows/dependabot.yml/badge.svg)](https://github.com/osinfra-io/terraform-google-kubernetes-engine/actions/workflows/dependabot.yml)

**[Infracost](https://www.infracost.io):**

[![infracost](https://img.shields.io/endpoint?label=default_kubernetes_engine&url=https://dashboard.api.infracost.io/shields/json/cbeecfe3-576f-4553-984c-e451a575ee47/repos/b4d909ac-2f7e-4c12-92c9-fe6759755494/branch/a863d75f-3eaa-49c4-a28b-2de0e18da95d/default_kubernetes_engine)](https://dashboard.infracost.io/org/osinfra-io/repos/b4d909ac-2f7e-4c12-92c9-fe6759755494?tab=settings)

Monthly cost estimates for this module based on these usage values:

- [default kubernetes engine](test/fixtures/default_kubernetes_engine/infracost-usage.yml)

## Repository Description

Terraform **example** module for a Google Cloud Platform Kubernetes engine cluster.

💡 *We do not recommend consuming this module like you might a [public module](https://registry.terraform.io/browse/modules). Its purpose is to be a baseline, something you can fork, potentially maintain, and modify to fit your organization's needs. Using public modules vs. writing your own has various [drivers and trade-offs](https://docs.osinfra.io/fundamentals/architecture-decision-records/adr-0003) that your organization should evaluate.*

## 🔩 Usage

You can check the [test/fixtures](test/fixtures/) directory for example configurations. These fixtures set up the system for testing by providing all the necessary code to initialize it, thus creating good examples to base your configurations on.

Google project services must be enabled before using this module. As a best practice, these should be defined in the [terraform-google-project](https://github.com/osinfra-io/terraform-google-project) module. The following services are required:

- container.googleapis.com
- cloudkms.googleapis.com

> NOTE: The `google-beta` provider is required for the autoscaling profile feature.
> Include this provider in your root module required_providers block if you use GitHub Dependabot.

Here is an example of a basic configuration:

```hcl
module "kubernetes-engine" {
  source = "git@github.com:osinfra-io/terraform-google-kubernetes-engine//regional?ref=v0.0.0"

  cost_center                    = "x000"
  cluster_prefix                 = "example-k8s-cluster"
  cluster_secondary_range_name   = "example-k8s-pods-us-east1"
  host_project_id                = "example-host-project"
  network                        = "example-vpc"

  node_pools = {
    standard-pool = {
      machine_type = "g1-small"
    }
  }

  master_ipv4_cidr_block         = "10.61.224.0/28"
  project_id                     = "example-project"
  project_number                 = "123456789"
  region                         = "us-east1"
  services_secondary_range_name  = "kitchen-k8s-services-us-east1"
  subnet                         = "example-subnet-us-east1"
}
```

## <img align="left" width="35" height="35" src="https://github.com/osinfra-io/github-organization-management/assets/1610100/39d6ae3b-ccc2-42db-92f1-276a5bc54e65"> Development

Our focus is on the core fundamental practice of platform engineering, Infrastructure as Code.

>Open Source Infrastructure (as Code) is a development model for infrastructure that focuses on open collaboration and applying relative lessons learned from software development practices that organizations can use internally at scale. - [Open Source Infrastructure (as Code)](https://www.osinfra.io)

To avoid slowing down stream-aligned teams, we want to open up the possibility for contributions. The Open Source Infrastructure (as Code) model allows team members external to the platform team to contribute with only a slight increase in cognitive load. This section is for developers who want to contribute to this repository, describing the tools used, the skills, and the knowledge required, along with Terraform documentation.

See the documentation for setting up a local development environment [here](https://docs.osinfra.io/fundamentals/development-setup).

### 🛠️ Tools

- [infracost](https://github.com/infracost/infracost)
- [inspec](https://github.com/inspec/inspec)
- [kitchen-terraform](https://github.com/newcontext-oss/kitchen-terraform)
- [pre-commit](https://github.com/pre-commit/pre-commit)
- [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform)
- [terraform-docs](https://github.com/terraform-docs/terraform-docs)

### 📋 Skills and Knowledge

Links to documentation and other resources required to develop and iterate in this repository successfully.

- [kubernetes engine](https://cloud.google.com/kubernetes-engine/docs)
  - [node pools](https://cloud.google.com/kubernetes-engine/docs/concepts/node-pools)
- [shared vpc](https://cloud.google.com/vpc/docs/shared-vpc)
  - [cluster creation](https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-shared-vpc)

### 🔍 Tests

You'll need to be a member of the [platform-contributors](https://groups.google.com/a/osinfra.io/g/platform-contributors) Google Group to run the tests. This group manages access to Testing/Sandbox folder in the resource hierarchy. You can request access to this group by opening an issue [here](https://github.com/osinfra-io/google-cloud-hierarchy/issues/new?assignees=&labels=enhancement&projects=&template=add-update-identity-group.yml&title=Add+or+update+identity+group).

```none
bundle install
```

```none
bundle exec kitchen converge
```

```none
bundle exec kitchen verify
```

```none
bundle exec kitchen destroy
```

## 📓 Terraform Documentation

- [regional](regional/README.md)
