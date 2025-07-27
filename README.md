# <img align="left" width="45" height="45" src="https://github.com/osinfra-io/opentofu-google-kubernetes-engine/assets/1610100/38c94ec5-3cef-4716-9744-791d4df598ba"> Google Cloud Platform - Kubernetes Engine OpenTofu Module

**[GitHub Actions](https://github.com/osinfra-io/opentofu-google-kubernetes-engine/actions):**

[![OpenTofu Tests](https://github.com/osinfra-io/opentofu-google-kubernetes-engine/actions/workflows/test.yml/badge.svg)](https://github.com/osinfra-io/opentofu-google-kubernetes-engine/actions/workflows/test.yml) [![Dependabot](https://github.com/osinfra-io/opentofu-google-kubernetes-engine/actions/workflows/dependabot.yml/badge.svg)](https://github.com/osinfra-io/opentofu-google-kubernetes-engine/actions/workflows/dependabot.yml)

**[Infracost](https://www.infracost.io):**

[![infracost](https://img.shields.io/endpoint?url=https://dashboard.api.infracost.io/shields/json/cbeecfe3-576f-4553-984c-e451a575ee47/repos/b4d909ac-2f7e-4c12-92c9-fe6759755494/branch/a863d75f-3eaa-49c4-a28b-2de0e18da95d)](https://dashboard.infracost.io/org/osinfra-io/repos/b4d909ac-2f7e-4c12-92c9-fe6759755494?tab=settings)

💵 Monthly estimates based on Infracost baseline costs.

## Repository Description

OpenTofu **example** module for a Google Cloud Platform Kubernetes engine cluster.

> [!NOTE]
> We do not recommend consuming this module like you might a [public module](https://search.opentofu.org). It is a baseline, something you can fork, potentially maintain, and modify to fit your organization's needs. Using public modules vs. writing your own has various [drivers and trade-offs](https://docs.osinfra.io/fundamentals/architecture-decision-records/adr-0003) that your organization should evaluate.

## 🔩 Usage

> [!TIP]
> You can check the [tests/fixtures](tests/fixtures) directory for example configurations. These fixtures set up the system for testing by providing all the necessary initial code, thus creating good examples on which to base your configurations.

Google project services must be enabled before using this module. As a best practice, these should be defined in the [opentofu-google-project](https://github.com/osinfra-io/opentofu-google-project) module. The following services are required:

- `container.googleapis.com`
- `cloudkms.googleapis.com`
- `cloudresourcemanager.googleapis.com`
- `gkehub.googleapis.com` (Only needed if the project is a GKE Fleet host project)
- `multiclusteringress.googleapis.com` (Only needed if the project is a GKE Fleet host project)
- `multiclusterservicediscovery.googleapis.com`
- `trafficdirector.googleapis.com`

## <img align="left" width="35" height="35" src="https://github.com/osinfra-io/github-organization-management/assets/1610100/39d6ae3b-ccc2-42db-92f1-276a5bc54e65"> Development

Our focus is on the core fundamental practice of platform engineering, Infrastructure as Code.

>Open Source Infrastructure (as Code) is a development model for infrastructure that focuses on open collaboration and applying relative lessons learned from software development practices that organizations can use internally at scale. - [Open Source Infrastructure (as Code)](https://www.osinfra.io)

To avoid slowing down stream-aligned teams, we want to open up the possibility for contributions. The Open Source Infrastructure (as Code) model allows team members external to the platform team to contribute with only a slight increase in cognitive load. This section is for developers who want to contribute to this repository, describing the tools used, the skills, and the knowledge required, along with OpenTofu documentation.

See the [documentation](https://docs.osinfra.io/fundamentals/development-setup) for setting up a local development environment.

### 🛠️ Tools

- [infracost](https://github.com/infracost/infracost)
- [osinfra-pre-commit-hooks](https://github.com/osinfra-io/pre-commit-hooks)
- [pre-commit](https://github.com/pre-commit/pre-commit)

### 📋 Skills and Knowledge

Links to documentation and other resources required to develop and iterate in this repository successfully.

- [kubernetes engine](https://cloud.google.com/kubernetes-engine/docs)
  - [multi cluster ingress](https://cloud.google.com/kubernetes-engine/docs/concepts/multi-cluster-ingress)
  - [node pools](https://cloud.google.com/kubernetes-engine/docs/concepts/node-pools)
  - [RBAC](https://cloud.google.com/kubernetes-engine/docs/how-to/role-based-access-control)
  - [workload identity](https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity)
- [shared vpc](https://cloud.google.com/vpc/docs/shared-vpc)
  - [cluster creation](https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-shared-vpc)

### 🔍 Tests

All tests are [mocked](https://developer.hashicorp.com/terraform/language/tests/mocking) allowing us to test the module without creating infrastructure or requiring credentials. The trade-offs are acceptable in favor of speed and simplicity. In a OpenTofu test, a mocked provider or resource will generate fake data for all computed attributes that would normally be provided by the underlying provider APIs.

```none
terraform init
```

```none
terraform test
```

## 📓 OpenTofu Documentation

> A child module automatically inherits default (un-aliased) provider configurations from its parent. The provider versions below are informational only and do **not** need to align with the provider configurations from its parent.
