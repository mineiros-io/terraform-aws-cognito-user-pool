[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>][homepage]

[![license][badge-license]][apache20]
[![Terraform Version][badge-terraform]][releases-terraform]
[![Join Slack][badge-slack]][slack]

# What this example shows

The code in [main.tf]
shows how to deploy a Cognito User Pool with custom settings.

```hcl
module "cognito_user_pool" {
  source  = "mineiros-io/cognito-user-pool/aws"
  version = "~> 0.9.0"

  name = "complete-example-userpool"

  # We allow the public to create user profiles
  allow_admin_create_user_only = false

  enable_username_case_sensitivity = false
  advanced_security_mode           = "ENFORCED"

  alias_attributes = [
    "email",
    "phone_number",
    "preferred_username",
  ]

  auto_verified_attributes = [
    "email"
  ]

  # If invited by an admin
  invite_email_subject = "You've been invited to Mineiros.io"
  invite_email_message = "Hi {username}, your temporary password is '{####}'."
  invite_sms_message   = "Hi {username}, your temporary password is '{####}'."

  default_email_option  = "CONFIRM_WITH_LINK"
  email_subject_by_link = "Your Verification Link"
  email_message_by_link = "Please click the link below to verify your email address. {##Verify Email##}."
  sms_message           = "Your verification code is {####}."

  challenge_required_on_new_device = true
  user_device_tracking             = "USER_OPT_IN"

  # These paramters can be used to configure SES for emails
  # ...

  # Require MFA
  mfa_configuration        = "ON"
  allow_software_mfa_token = true

  password_minimum_length    = 40
  password_require_lowercase = true
  password_require_numbers   = true
  password_require_uppercase = true
  password_require_symbols   = true

  temporary_password_validity_days = 3

  schema_attributes = [
    {
      name       = "gender", # overwrites the default attribute 'gender'
      type       = "String"
      required   = true
      min_length = 1
      max_length = 2048
    },
    {
      name                     = "alternative_name"
      type                     = "String"
      developer_only_attribute = false,
      mutable                  = true,
      required                 = false,
      min_length               = 0,
      max_length               = 2048
    },
    {
      name      = "friends_count"
      type      = "Number"
      min_value = 0,
      max_value = 100
    },
    {
      name = "is_active"
      type = "Boolean"

    },
    {
      name = "last_seen"
      type = "DateTime"
    }
  ]

  clients = [
    {
      name                 = "android-mobile-client"
      read_attributes      = ["email", "email_verified", "preferred_username"]
      allowed_oauth_scopes = ["email", "openid"]
      allowed_oauth_flows  = ["implicit"]
      callback_urls        = ["https://mineiros.io/callback", "https://mineiros.io/anothercallback"]
      default_redirect_uri = "https://mineiros.io/callback"
      generate_secret      = true
    }
  ]

  tags = {
    environment = "Dev"
  }
}
```

## Running the example

### Cloning the repository

```bash
git clone https://github.com/mineiros-io/terraform-aws-cognito-user-pool.git
cd terraform-aws-cognito-user-pool/examples/complete
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

[main.tf]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/tree/master/examples/complete/main.tf

[homepage]: https://mineiros.io/?ref=terraform-aws-cognito-user-pool

[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[badge-terraform]: https://img.shields.io/badge/terraform-1.x%20|%200.15%20|%200.14%20|%200.13%20|%200.12.20+-623CE4.svg?logo=terraform
[badge-slack]: https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack

[releases-terraform]: https://github.com/hashicorp/terraform/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://join.slack.com/t/mineiros-community/shared_invite/zt-ehidestg-aLGoIENLVs6tvwJ11w9WGg
