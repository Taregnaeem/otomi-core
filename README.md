<h1 align="center">
  <img src="https://otomi.io/img/otomi-logo.svg" width="224px"/><br/>
  Shift left with Otomi
</h1>
<p align="center">Otomi makes developers self-serving and helps DevOps teams to guarantee application security and availability at the earliest stages in the development lifecycle when using <b>Kubernetes</b> while strongly relying on <b>GitOps</b> patterns, where desired state is reflected as code and the cluster state is automatically updated.<br/><br/>Install Otomi with one command on any Kubernetes cluster.</p>

<p align="center">
  <a href="https://github.com/redkubes/otomi-core/releases/"><img alt="Releases" src="https://img.shields.io/github/v/release/redkubes/otomi-core" /></a>
  <a href="https://img.shields.io/docker/pulls/otomi/core"><img alt="Docker pulls" src="https://img.shields.io/docker/pulls/otomi/core" /></a>
  <a href="https://img.shields.io/github/workflow/status/redkubes/otomi-core/Build%20and%20publish%20Docker"><img alt="Build status" src="https://img.shields.io/github/workflow/status/redkubes/otomi-core/Build%20and%20publish%20Docker" /></a>
  <a href="https://img.shields.io/github/last-commit/redkubes/otomi-core"><img alt="Last commit" src="https://img.shields.io/github/last-commit/redkubes/otomi-core" /></a>
  <a href="https://img.shields.io/crates/l/ap"><img alt="License" src="https://img.shields.io/crates/l/ap" /></a>
  <a href="https://img.shields.io/badge/contributions-welcome-orange.svg"><img alt="Contributions" src="https://img.shields.io/badge/contributions-welcome-orange.svg" /></a>
</p>

## ⚡️ Quick start

> 🔔 When installing Otomi using the quick start or installing with minimal values using Helm, you will not be able to pull images from the local Harbor registry unless you add the auto generated CA to all cluster nodes. To be able to pull images from Harbor without adding the CA to all cluster nodes, install Otomi with `hasExternalDNS=true` and `issuer=letsencrypt` (or BYO CA). See [otomi.io](https://otomi.io) for more instructions.

### `Terraform`

Use the Terraform quick start for Azure, GCP and AWS to provision a Kubernetes cluster in your cloud of choice and install Otomi with minimal values. Go to the [quickstart repository](https://github.com/redkubes/quickstart) to get started.

When the installer job has finished, copy the URL and the generated password from the bottom of the logs of the job (in the default namespace) and complete the [post-installion steps](https://otomi.io/docs/installation/post-install/).

### `Install with minimal values using Helm`

To install Otomi with minimal values using Helm, first create a `values.yaml` file with the following values:

```yaml
cluster:
  k8sVersion: '1.20' # 1.18, 1.19, 1.20 and 1.21 are supported
  name: # the name of your cluster
  owner: # the owner of the cluster
  provider: # choose between aws, azure, google or onprem
```

add the repository

```bash
helm repo add otomi https://otomi.io/otomi-core
helm repo update
```

and then install the Helm chart

```bash
helm install -f values.yaml otomi otomi/otomi
```

When the installer job has finished, copy the URL and the generated password from the bottom of the logs of the job (in the default namespace). and complete the [post-installion steps](https://otomi.io/docs/installation/post-install/).

After installing Otomi, you can use [Otomi Console](https://otomi.io/docs/console/) to access all integrated applications and use the self-service features to create new Knative services, publicly expose pre-deployed services, create secrets and create Kubernetes Jobs / Cron Jobs.

<p align="center"><img src="https://otomi.io/assets/images/console-apps-eed3320fa1754480a623287e0bbe2365.png" width="100%" align="center" alt="Otomi Console"></p>

## ⚙️ Advanced configuration

`Otomi` can be installed with the following advanced configuration options:

- Use an external DNS zone with LetsEncrypt certificates
- Configure Azure Active Directory as an IdP
- Use KMS to manage keys for encryption

Go to [otomi.io](https://otomi.io) for more detailed instructions.

## Key features

- Developer self-service
- Over 20 pre-configured and ready-to-use applications and add-ons
- Application configuration management
- Multi-tenancy
- Implemented security policies
- Single Sign On
- Automatic ingress configuration
- Input/output validation
- Automatic image vulnerability scanning
- Secrets management
- Full observability
- Kubernetes best-practices

Learn more about Otomi at [otomi.io](https://otomi.io/about).

## Integrated applications

`Otomi` ships with the following pre-configured and ready to use applications:

- [Istio](https://istio.io/): The service mesh framework with end-to-end transit encryption
- [Knative](https://knative.dev/): Deploy and manage serverless workloads
- [Promethues](https://prometheus.io/): Collecting container application metrics
- [Loki](https://grafana.com/oss/loki/): Collecting container application logs
- [Harbor](https://goharbor.io/): Container image registry with role-based access control, image scanning and image signing
- [HashiCorp Vault](https://www.vaultproject.io/): Manage Secrets and Protect Sensitive Data
- [Bitnami Kubeapps](https://bitnami.com/kubernetes/kubeapps): Launching and managing applications on Kubernetes
- [Keycloak](https://www.keycloak.org/): Identity and access management for modern applications and services
- [OPA](https://www.openpolicyagent.org/): Policy-based control for cloud native environments
- [Let's Encrypt](https://letsencrypt.org/): A nonprofit Certificate Authority providing industry recognized TLS certificates
- [Jaeger](https://www.jaegertracing.io/): End-to-end distributed tracing and monitor for complex distributed systems
- [Kiali](https://kiali.io/): Observe Istio service mesh relations and connections

## Projects

Otomi consists out of multiple projects:

- Otomi Core (this project): The heart of Otomi
- [Otomi Tasks](https://github.com/redkubes/otomi-tasks): Autonomous jobs orchestrated by Otomi Core
- [Otomi API](https://github.com/redkubes/otomi-api): The brain of Otomi, handling console input and talking to Otomi Core
- [Otomi Console](https://github.com/redkubes/otomi-console): The UI of Otomi for admins and teams, talking to Otomi API
- [Otomi Clients](https://github.com/redkubes/otomi-clients): Factory to build and publish openapi clients used in the redkubes/otomi-tasks repo

## 📖 Documentation

Check out the [dev docs index](./docs/index.md) for developer documentation or go to [otomi.io](https://otomi.io) for more detailed documentation.

## Contribution

If you wish to contribute please read our [Contributor Code of Conduct](https://otomi.io/community/code-of-conduct) and [Contribution Guidelines](https://otomi.io/community/get-involved).

If you want to say **thank you** or/and support active development of `Otomi`:

- Add a [GitHub Star](https://github.com/redkubes/otomi-core) to the project.
- Write interesting articles about project on [Dev.to](https://dev.to/), [Medium](https://medium.com/) or personal blog.

## ⚠️ License

`Otomi` is free and open-source software licensed under the [Apache 2.0 License](https://github.com/redkubes/otomi-core/blob/master/LICENSE).

