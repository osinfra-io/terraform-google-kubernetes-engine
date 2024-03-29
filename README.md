# <img align="left" width="45" height="45" src="https://github.com/osinfra-io/terraform-google-kubernetes-engine/assets/1610100/38c94ec5-3cef-4716-9744-791d4df598ba"> Google Cloud Platform - Kubernetes Engine Terraform Module

**[GitHub Actions](https://github.com/osinfra-io/terraform-google-kubernetes-engine/actions):**

[![Kitchen Tests](https://github.com/osinfra-io/terraform-google-kubernetes-engine/actions/workflows/kitchen.yml/badge.svg)](https://github.com/osinfra-io/terraform-google-kubernetes-engine/actions/workflows/kitchen.yml) [![CodeQL](https://github.com/osinfra-io/terraform-google-kubernetes-engine/actions/workflows/github-code-scanning/codeql/badge.svg)](https://github.com/osinfra-io/terraform-google-kubernetes-engine/actions/workflows/github-code-scanning/codeql) [![Dependabot](https://github.com/osinfra-io/terraform-google-kubernetes-engine/actions/workflows/dependabot.yml/badge.svg)](https://github.com/osinfra-io/terraform-google-kubernetes-engine/actions/workflows/dependabot.yml)

**[Infracost](https://www.infracost.io):**

[![infracost](https://img.shields.io/endpoint?url=https://dashboard.api.infracost.io/shields/json/cbeecfe3-576f-4553-984c-e451a575ee47/repos/b4d909ac-2f7e-4c12-92c9-fe6759755494/branch/a863d75f-3eaa-49c4-a28b-2de0e18da95d)](https://dashboard.infracost.io/org/osinfra-io/repos/b4d909ac-2f7e-4c12-92c9-fe6759755494?tab=settings)

💵 Monthly estimates for this module based on Infracost baseline costs.

## Repository Description

Terraform **example** module for a Google Cloud Platform Kubernetes engine cluster.

> [!NOTE]
> We do not recommend consuming this module like you might a [public module](https://registry.terraform.io/browse/modules). It is a baseline, something you can fork, potentially maintain, and modify to fit your organization's needs. Using public modules vs. writing your own has various [drivers and trade-offs](https://docs.osinfra.io/fundamentals/architecture-decision-records/adr-0003) that your organization should evaluate.

## 🔩 Usage

> [!TIP]
> You can check the [test/fixtures](test/fixtures/) directory for example configurations. These fixtures set up the system for testing by providing all the necessary initial code, thus creating good examples to base your configurations.

Google project services must be enabled before using this module. As a best practice, these should be defined in the [terraform-google-project](https://github.com/osinfra-io/terraform-google-project) module. The following services are required:

- `container.googleapis.com`
- `cloudkms.googleapis.com`
- `cloudresourcemanager.googleapis.com`
- `gkehub.googleapis.com` (Only needed if the project is a GKE Fleet host project)
- `multiclusteringress.googleapis.com` (Only needed if the project is a GKE Fleet host project)
- `multiclusterservicediscovery.googleapis.com`
- `trafficdirector.googleapis.com`

> NOTE: The autoscaling profile feature requires the `google-beta` provider.
> Include this provider in your root module required_providers block if you use GitHub Dependabot.

## <img align="left" width="35" height="35" src="https://github.com/osinfra-io/github-organization-management/assets/1610100/39d6ae3b-ccc2-42db-92f1-276a5bc54e65"> Development

Our focus is on the core fundamental practice of platform engineering, Infrastructure as Code.

>Open Source Infrastructure (as Code) is a development model for infrastructure that focuses on open collaboration and applying relative lessons learned from software development practices that organizations can use internally at scale. - [Open Source Infrastructure (as Code)](https://www.osinfra.io)

To avoid slowing down stream-aligned teams, we want to open up the possibility for contributions. The Open Source Infrastructure (as Code) model allows team members external to the platform team to contribute with only a slight increase in cognitive load. This section is for developers who want to contribute to this repository, describing the tools used, the skills, and the knowledge required, along with Terraform documentation.

See the documentation for setting up a local development environment [here](https://docs.osinfra.io/fundamentals/development-setup).

### 🛠️ Tools

- [helm](https://helm.sh)
- [infracost](https://github.com/infracost/infracost)
- [inspec](https://github.com/inspec/inspec)
- [kitchen-terraform](https://github.com/newcontext-oss/kitchen-terraform)
- [pre-commit](https://github.com/pre-commit/pre-commit)
- [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform)
- [terraform-docs](https://github.com/terraform-docs/terraform-docs)

### 📋 Skills and Knowledge

Links to documentation and other resources required to develop and iterate in this repository successfully.

- [istio](https://istio.io/latest/docs)
  - [istio on gke](https://istio.io/latest/docs/setup/platform-setup/gke)
- [kubernetes engine](https://cloud.google.com/kubernetes-engine/docs)
  - [multi cluster ingress](https://cloud.google.com/kubernetes-engine/docs/concepts/multi-cluster-ingress)
  - [node pools](https://cloud.google.com/kubernetes-engine/docs/concepts/node-pools)
  - [RBAC](https://cloud.google.com/kubernetes-engine/docs/how-to/role-based-access-control)
  - [workload identity](https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity)
- [shared vpc](https://cloud.google.com/vpc/docs/shared-vpc)
  - [cluster creation](https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-shared-vpc)

### 🔍 Tests

You'll need to be a member of the [platform-contributors](https://groups.google.com/a/osinfra.io/g/platform-contributors) Google Group to run the tests. This group manages access to Testing/Sandbox folder in the resource hierarchy. You can request access to this group by opening an issue [here](https://github.com/osinfra-io/google-cloud-hierarchy/issues/new?assignees=&labels=enhancement&projects=&template=add-update-identity-group.yml&title=Add+or+update+identity+group).

#### Converge and Verify

```none
test/test.sh
```

#### Destroy

```none
test/test.sh -d
```

## 📓 Terraform Documentation

- [global](global/README.md)
- [regional](regional/README.md)
- [regional/istio](regional/istio/README.md)
- [regional/mci](regional/mci/README.md)
- [regional/onboarding](regional/onboarding/README.md)
