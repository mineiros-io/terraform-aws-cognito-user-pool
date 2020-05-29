[<img src="https://raw.githubusercontent.com/mineiros-io/brand/e9fff6ecb9617dcb405079f301e23fd83b79c5f3/mineiros-primary-logo.svg" width="400"/>](https://www.mineiros.io/?ref=terraform-aws-cognito-user-pool)

[![Build Status](https://mineiros.semaphoreci.com/badges/terraform-aws-cognito-user-pool/branches/master.svg?style=shields&key=45df31b5-397b-427e-9b96-b995b0daf7c2)](https://mineiros.semaphoreci.com/projects/terraform-aws-cognito-user-pool)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/terraform-aws-cognito-user-pool.svg?label=latest&sort=semver)](https://github.com/mineiros-io/terraform-aws-cognito-user-pool/releases)
[![license](https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg)](https://opensource.org/licenses/Apache-2.0)
[![Terraform Version](https://img.shields.io/badge/terraform-~%3E%200.12.20-623CE4.svg)](https://github.com/hashicorp/terraform/releases)
[<img src="https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack">](https://join.slack.com/t/mineiros-community/shared_invite/zt-ehidestg-aLGoIENLVs6tvwJ11w9WGg)

# terraform-aws-cognito-user-pool

A [Terraform](https://www.terraform.io) 0.12 base module for
[Amazon Web Services (AWS)](https://aws.amazon.com/).

- [Module Features](#module-features)
- [Getting Started](#getting-started)
- [Module Argument Reference](#module-argument-reference)
  - [Module Configuration](#module-configuration)
  - [Top-level Arguments](#top-level-arguments)
    - [Main Resource Configuration](#main-resource-configuration)
    - [Extended Resource configuration](#extended-resource-configuration)
- [Module Attributes Reference](#module-attributes-reference)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Module Features

In contrast to the plain `terraform_resource` resource this module has better features.
While all security features can be disabled as needed best practices
are pre-configured.

In addition to cool features we also have awesome features.

- **Default Security Settings**:
  Secure by default by setting security to `true`,
  Additional security addedy setting some feature to `enabeled`.

- **Standard Module Features**:
  Cool Feature of the main resource,
  Tags

- **Extended Module Features**:
  Awesome extended feature of an additional related resource,
  And another cool feature

- **Additional Features**:
  A cool feature that is not actually a resource but a cool set up from us

- *Features not yet implemented*:
  Standard features missing,
  Extended features planned,
  Additional features planned

## Getting Started

Most basic usage just setting required arguments:

```hcl
module "terraform-aws-cognito-user-pool" {
  source = "git@github.com:mineiros-io/terraform-aws-cognito-user-pool.git?ref=v0.0.1"
}
```

Advanced usage as found in
[examples/example/main.tf](https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/examples/example/main.tf)
setting all required and optional arguments to their default values.

```hcl
module "terraform-aws-cognito-user-pool" {
  source = "git@github.com:mineiros-io/terraform-aws-cognito-user-pool.git?ref=v0.0.1"

  ...

  module_enabled    = true
  module_depends_on = []
}
```

## Module Argument Reference

See
[variables.tf](https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/variables.tf)
and
[examples/](https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/examples)
for details and use-cases.

### Module Configuration

- **`module_enabled`**: *(Optional `bool`)*
Specifies whether resources in the module will be created.
Default is `true`.

- **`module_depends_on`**: *(Optional `list(any)`)*
A list of dependencies. Any object can be assigned to this list to define a hidden
external dependency.

### Top-level Arguments

#### Main Resource Configuration

#### Extended Resource configuration

## Module Attributes Reference

The following attributes are exported by the module:


## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)](https://semver.org/).

Using the given version number of `MAJOR.MINOR.PATCH`, we apply the following constructs:

1. Use the `MAJOR` version for incompatible changes.
1. Use the `MINOR` version when adding functionality in a backwards compatible manner.
1. Use the `PATCH` version when introducing backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version

- In the context of initial development, backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is
  increased. (Initial development)
- In the context of pre-release, backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is
increased. (Pre-release)

## About Mineiros

Mineiros is a [DevOps as a Service](https://www.mineiros.io/?ref=terraform-aws-cognito-user-pool) company based in Berlin, Germany. We offer commercial support
for all of our projects and encourage you to reach out if you have any questions or need help.
Feel free to send us an email at [hello@mineiros.io](mailto:hello@mineiros.io) or join our [Community Slack channel](https://join.slack.com/t/mineiros-community/shared_invite/zt-ehidestg-aLGoIENLVs6tvwJ11w9WGg). 

- Terraform Modules for all types of infrastructure such as VPC's, Docker clusters,
databases, logging and monitoring, CI, etc.
- Consulting & Training on AWS, Terraform and DevOps.

## Reporting Issues

We use GitHub [Issues](https://github.com/mineiros-io/terraform-aws-cognito-user-pool/issues)
to track community reported issues and missing features.

## Contributing

Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests](https://github.com/mineiros-io/terraform-aws-cognito-user-pool/pulls). If you’d like more information, please
see our [Contribution Guidelines](https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/CONTRIBUTING.md).

## Makefile Targets

This repository comes with a handy
[Makefile](https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/Makefile).
Run `make help` to see details on each available target.

## License

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE](https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/LICENSE) for full details.

Copyright &copy; 2020 Mineiros GmbH
