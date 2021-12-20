[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>][homepage]

[![license][badge-license]][apache20]
[![Terraform Version][badge-terraform]][releases-terraform]
[![Join Slack][badge-slack]][slack]

# What this example shows

The code in [main.tf]
shows how to deploy a Cognito User Pool with default settings that are
defined in the [variables.tf] file of this module.

```hcl
module "cognito_user_pool" {
  source  = "mineiros-io/cognito-user-pool/aws"
  version = "~> 0.8.0"

  name = "example-userpool"
}
```

## Running the example

### Cloning the repository

```bash
git clone https://github.com/mineiros-io/terraform-aws-cognito-user-pool.git
cd terraform-aws-cognito-user-pool/examples/user-pool-with-default-settings
```

### Initializing Terraform

Run `terraform init` to initialize the example and download providers and the module.

### Planning the example

Run `terraform plan` to see a plan of the changes.

### Applying the example

Run `terraform apply` to create the resources.
You will see a plan of the changes and Terraform will prompt you for approval to actually apply the changes.

### Destroying the example

Run `terraform destroy` to destroy all resources again.

<!-- References -->

[main.tf]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/tree/master/examples/user-pool-with-default-settings/main.tf
[variables.tf]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/tree/master/variables.tf

[homepage]: https://mineiros.io/?ref=terraform-aws-cognito-user-pool

[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[badge-terraform]: https://img.shields.io/badge/terraform-1.x%20|%200.15%20|%200.14%20|%200.13%20|%200.12.20+-623CE4.svg?logo=terraform
[badge-slack]: https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack

[releases-terraform]: https://github.com/hashicorp/terraform/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://join.slack.com/t/mineiros-community/shared_invite/zt-ehidestg-aLGoIENLVs6tvwJ11w9WGg
