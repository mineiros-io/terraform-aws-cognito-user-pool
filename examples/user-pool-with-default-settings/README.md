[<img src="https://raw.githubusercontent.com/mineiros-io/brand/e9fff6ecb9617dcb405079f301e23fd83b79c5f3/mineiros-primary-logo.svg" width="400"/>](https://www.mineiros.io/?ref=terraform-aws-cognito-user-pool)

[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/terraform-aws-cognito-user-pool.svg?label=latest&sort=semver)](https://github.com/mineiros-io/terraform-aws-cognito-user-pool/releases)
[![license](https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg)](https://opensource.org/licenses/Apache-2.0)
[![Terraform Version](https://img.shields.io/badge/terraform-~%3E%200.12.20-623CE4.svg)](https://github.com/hashicorp/terraform/releases)
[<img src="https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack">](https://join.slack.com/t/mineiros-community/shared_invite/zt-ehidestg-aLGoIENLVs6tvwJ11w9WGg)

# What this example shows

The code in [main.tf](https://github.com/mineiros-io/terraform-aws-cognito-user-pool/tree/master/examples/user-pool-with-default-settings/main.tf)
shows how to deploy a Cognito User Pool with default settings that are
defined in the
[variables.tf](https://github.com/mineiros-io/terraform-aws-cognito-user-pool/tree/master/examples/user-pool-with-default-settings/variables.tf)
file of this module. 

## How to run the example

### Clone the repository

```bash
git clone https://github.com/mineiros-io/terraform-module-template.git
cd terraform-module-template/examples/user-pool-with-default-settings
```

### Initialize Terraform

Run `terraform init` to initialize the example. The output should look like:

### Apply the example

Run `terraform apply` to create the resources.

### Destroy the example

Run `terraform destroy -refresh=false -auto-approve` to destroy all resources again.
