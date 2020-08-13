[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>][homepage]

[![Build Status][badge-build]][build-status]
[![GitHub tag (latest SemVer)][badge-semver]][releases-github]
[![license][badge-license]][apache20]
[![Terraform Version][badge-terraform]][releases-terraform]
[![Join Slack][badge-slack]][slack]

# terraform-aws-cognito-user-pool

A [Terraform] 0.12 module for deploying and managing
[Cognito User Pools]
on [Amazon Web Services (AWS)][AWS].

- [Module Features](#module-features)
- [Getting Started](#getting-started)
- [Module Argument Reference](#module-argument-reference)
  - [Top-level Arguments](#top-level-arguments)
    - [Module Configuration](#module-configuration)
    - [Cognito User Pool](#cognito-user-pool)
    - [Cognito User Pool Domain](#cognito-user-pool-domain)
    - [Cognito User Pool Clients](#cognito-user-pool-clients)
    - [Cognito User Pool Clients Default Values](#cognito-user-pool-clients-default-values)
- [Module Attributes Reference](#module-attributes-reference)
- [External Documentation](#external-documentation)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Module Features

In contrast to the plain [`cognito_user_pool`](https://www.terraform.io/docs/providers/aws/r/cognito_user_pool.html)
resource this module has a more secure level of default settings.

While all settings can be customized as needed, best practices are
pre-configured.

- **Default Security Settings**:
  Per default, only administrators are allowed to create user profiles by
  setting `allow_admin_create_user_only` to `true`. This module comes with a
  strong default password policy.

**Standard Cognito Features**:
  Create a Cognito User Pool with pre-configured best practices.
  Create Cognito User Pool Clients.
  Create a Cognito User Pool Domain.

- *Features not yet implemented*:
  [`cognito_user_group`](https://www.terraform.io/docs/providers/aws/r/cognito_user_group.html)
  [`cognito_resource_server`](https://www.terraform.io/docs/providers/aws/r/cognito_resource_server.html)

## Getting Started

Most basic usage just setting required arguments:

```hcl
module "terraform-aws-cognito-user-pool" {
  source  = "mineiros-io/cognito-user-pool/aws"
  version = "~> 0.1.2"

  name = "application-userpool"
}
```

Advanced usage as found in
[examples/complete/main.tf](https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/examples/complete/main.tf)
setting all required and optional arguments to their default values.

## Module Argument Reference

See
[variables.tf](https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/variables.tf)
and
[examples/](https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/examples)
for details and use-cases.

### Top-level Arguments

#### Module Configuration

- **`module_enabled`**: *(Optional `bool`)*

  Specifies whether resources in the module will be created.
  Default is `true`.

- **`module_depends_on`**: *(Optional `list(any)`)*

  A list of dependencies. Any object can be _assigned_ to this list to define a
  hidden external dependency. Default is `[]`.

#### Cognito User Pool

- **`name`**: **(Required `string`, Forces new resource)**

  The name of the user pool.

- **`advanced_security_mode`**: *(Optional `string`)*

  The mode for advanced security, must be one of `OFF`, `AUDIT` or `ENFORCED`. Additional pricing applies for Amazon Cognito advanced security features. For details see https://aws.amazon.com/cognito/pricing/.
  Default is `OFF`.

- **`alias_attributes`**: *(Optional `set(string)`)*

  Attributes supported as an alias for this user pool. Possible values: `phone_number`, `email`, or `preferred_username`.
  Conflicts with `username_attributes`.
  Default is `["email", "preferred_username",]` if `username_attributes` is not set.

- **`username_attributes`**: *(Optional `set(string)`)*

  Specifies whether `email` addresse or `phone_number` can be specified as usernames when a user signs up. Conflicts with `alias_attributes`.
  Default is to use `alias_attributes`.

- **`allow_admin_create_user_only`**: *(Optional `bool`)*

  Set to True if only the administrator is allowed to create user profiles. Set to False if users can sign themselves up via an app.
  Default is `true`.

- **`invite_email_subject`**: *(Optional `string`)*

  The message template for email messages.
  Default is `"Your verification code"`.

- **`invite_email_message`**: *(Optional `string`)*

  The message template for email messages. Must contain `{username}` and `{####}` placeholders, for username and temporary password, respectively.
  Default is `"Your username is {username} and your temporary password is '{####}'"`.

- **`invite_sms_message`**: *(Optional `string`)*

  The message template for SMS messages. Must contain `{username}` and `{####}` placeholders, for username and temporary password, respectively.
  Default is `"Your username is {username} and your temporary password is '{####}'."`.

- **`auto_verified_attributes`**: *(Optional `set(string)`)*

  The attributes to be auto-verified. Possible values: `email`, `phone_number`.
  Default is `["email"]`.

- **`challenge_required_on_new_device`**: *(Optional `bool`)*
  Indicates whether a challenge is required on a new device. Only applicable to a new device.
  Default is `true`.

- **`device_only_remembered_on_user_prompt`**: *(Optional `string`)*

  If true, a device is only remembered on user prompt.
  Default is `true`.

- **`enable_username_case_sensitivity`**: *(Optional `bool`)*

  Specifies whether username case sensitivity will be applied to all users in the user pool through Cognito APIs.
  Default is `false`.

- **`email_sending_account`**: *(Optional `string`)*

  The email delivery method to use. `COGNITO_DEFAULT` for the default email functionality built into Cognito or `DEVELOPER` to use your Amazon SES configuration.
  Default is `"COGNITO_DEFAULT"`.

- **`email_reply_to_address`**: *(Optional `string`)*

  The REPLY-TO email address.
  Default is `null`.

- **`email_source_arn`**: *(Optional `string`)*

  The ARN of the email source.
  Default is `null`.

<!-- markdown-link-check-disable -->
- **`email_from_address`**: *(Optional `string`)*

  Sender’s email address or sender’s name with their email address (e.g. 'john@smith.com' or 'John Smith <john@smith.com>').
  Default is `null`.
<!-- markdown-link-check-enable -->

- **`mfa_configuration`**: *(Optional `string`)*

  Multi-Factor Authentication (MFA) configuration for the User Pool. Valid values: `ON`, `OFF` or `OPTIONAL`. `ON` and `OPTIONAL` require at least one of `sms_configuration` or `software_token_mfa_configuration` to be configured.
  Default is `"OPTIONAL"`.

- **`password_minimum_length`**: *(Optional `number`)*

  The minimum length of the password policy that you have set.
  Default is `20`.

- **`password_require_lowercase`**: *(Optional `bool`)*

  Whether you have required users to use at least one lowercase letter in their password.
  Default is `true`.

- **`password_require_numbers`**: *(Optional `bool`)*

  Whether you have required users to use at least one number in their password.
  Default is `true`.

- **`password_require_symbols`**: *(Optional `bool`)*

  Whether you have required users to use at least one symbol in their password.
  Default is `true`.

- **`password_require_uppercase`**: *(Optional `bool`)*

  Whether you have required users to use at least one uppercase letter in their password.
  Default is `true`.

- **`temporary_password_validity_days`**: *(Optional `number`)*

  In the password policy you have set, refers to the number of days a temporary password is valid. If the user does not sign in during this time, their password will need to be reset by an administrator.
  Default is `1`.

- **`allow_software_mfa_token`**: *(Optional `bool`)*

  Boolean whether to enable software token Multi-Factor Authentication (MFA) tokens, such as Time-Based One-Time Password (TOTP). To disable software token MFA when `sms_configuration` is not present, the `mfa_configuration` argument must be set to `OFF` and the `software_token_mfa_configuration` configuration block must be fully removed.
  Default is `true`.

- **`sms_authentication_message`**: *(Optional `string`)*

  A string representing the SMS authentication message. The message must contain the `{####}` placeholder, which will be replaced with the authentication code.
  Default is `"Your temporary password is {####}."`.

- **`lambda_create_auth_challenge`**: *(Optional `string`)*

  The ARN of an AWS Lambda creating an authentication challenge.
  Default is `null`.

- **`lambda_custom_message`**: *(Optional `string`)*

  The ARN of a custom message AWS Lambda trigger.
  Default is `null`.

- **`lambda_define_auth_challenge`**: *(Optional `string`)*

  The ARN of an AWS Lambda that defines the authentication challenge.
  Default is `null`.

- **`lambda_post_authentication`**: *(Optional `string`)*

  The ARN of an AWS Lambda that defines the authentication challenge.
  Default is `null`.

- **`lambda_post_confirmation`**: *(Optional `string`)*

  The ARN of a post-confirmation AWS Lambda trigger.
  Default is `null`.

- **`lambda_pre_authentication`**: *(Optional `string`)*

  The ARN of a pre-authentication AWS Lambda trigger.
  Default is `null`.

- **`lambda_pre_sign_up`**: *(Optional `string`)*

  The ARN of a pre-registration AWS Lambda trigger.
  Default is `null`.

- **`lambda_pre_token_generation`**: *(Optional `string`)*

  The ARN of an AWS Lambda that allows customization of identity token claims before token generation.
  Default is `null`.

- **`lambda_user_migration`**: *(Optional `string`)*

  The ARN of he user migration AWS Lambda config type.
  Default is `null`.

- **`lambda_verify_auth_challenge_response`**: *(Optional `string`)*

  The ARN of an AWS Lambda that verifies the authentication challenge response.
  Default is `true`.

- **`schema_attributes`**: *(Optional `any`)*

  A list of schema attributes of a user pool. You can add a maximum um 25 custom
  attributes. Please note that only default attributes can be marked as required.
  Also an attribute cannot be switched between required and not required after a
  user pool has been created.
  For details please see the [attributes docs].
  Default is `[]`.

  **Example:**

  ```hcl
    schema_attributes = [
      {
        name = "gender", # overwrites the default attribute 'gender'
        type = "String"
        required = true  # required can only be set for default attributes
      },
      {
        name       = "alternative_name"
        type       = "String"
        min_length = 0,
        max_length = 2048
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
  ```

- **`sms_configuration`**: *(Optional `object({external_id = string, sns_caller_arn = string})`)*

  The `sms_configuration` with the `external_id` parameter used in IAM role trust relationships and the `sns_caller_arn` parameter to set the ARN of the Amazon SNS caller. This is usually the IAM role that you have given AWS Cognito permission to assume.
  Default is `null`.

- **`default_email_option`**: *(Optional `string`)*

  The default email option. Must be either `CONFIRM_WITH_CODE` or `CONFIRM_WITH_LINK`.
  Default is `"CONFIRM_WITH_CODE"`.

- **`email_message`**: *(Optional `string`)*

  The email message template. Must contain the `{####}` placeholder.
  Default is `"Your verification code is {####}."`.

- **`email_message_by_link`**: *(Optional `string`)*

  The email message template for sending a confirmation link to the user, it must contain the `{##Click Here##}` placeholder.
  Default is `"Please click the link below to verify your email address. {##Verify Email##}."`.

- **`email_subject`**: *(Optional `string`)*

  The subject line for the email message template.
  Default is `"Your Verification Code"`.

- **`email_subject_by_link`**: *(Optional `string`)*

  The subject line for the email message template for sending a confirmation link to the user.
  Default is `"Your Verifiction Link"`.

- **`sms_message`**: *(Optional `string`)*

  The SMS message template. Must contain the `{####}` placeholder, which will be replaced with the verification code. Can also contain the `{username}` placeholder which will be replaced with the username.
  Default is `"Your verification code is {####}."`.

- **`tags`**: *(Optional `map(string)`)*

  A mapping of tags to assign to the resource.
  Default is `{}`.

  **Example:**

  ```hcl
  tags  = {
    CreatedAt = "2020-02-07",
    Alice     = "Bob"
  }
  ```
#### Cognito User Pool Domain

- **`domain`**: *(Optional `string`)*

  The domain name that should be used. Can be set to a FQDN or prefix.
  If no FQDN and `certificate_arn` are set, the domain prefix will be used for
  the sign-up and sign-in pages that are hosted by Amazon Cognito,
  e.g. `https://{YOUR_PREFIX}.auth.eu-west-1.amazoncognito.com`.
  The prefix must be unique across the selected AWS Region.
  Domain names can only contain lower-case letters, numbers, and hyphens.

    Default is not to use a custom domain.

- **`certificate_arn `**: *(Optional `string`)*

  The ARN of an ISSUED ACM certificate in us-east-1 for a custom domain.
  Default is not to use a custom domain.

#### Cognito User Pool Clients

- **`clients`**: *(Optional `list(client)`)*

  A list of objects with the clients definitions.
  Default is `[]`.

  **Example:**

  A list of clients that follow the normal schema defined by the provider.
  For details please see [Terraform AWS Cognito User Pool Client Docs].

  ```hcl
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
  ```

#### Cognito User Pool Clients Default Values

  The following variables can be used for setting default settings among various clients defined through the `clients`
  variable. This helps you to quickly issue several clients that implement the same settings, e.g. like so:

  ```hcl
  clients = [
    { name = "ios" },
    { name = "android" },
    { name = "web" },
  ]

  default_client_read_attributes        = ["email", "email_verified", "preferred_username"]
  default_client_allowed_oauth_scopes   = ["email", "openid"]
  default_client_allowed_oauth_flows    = ["implicit"]
  default_client_callback_urls          = ["https://mineiros.io/callback", "https://mineiros.io/anothercallback"]
  default_client_default_redirect_uri   = "https://mineiros.io/callback"
  default_client_generate_secret        = true
  default_client_refresh_token_validity = 45

  default_client_supported_identity_providers         = null
  default_client_logout_urls                          = null
  default_client_allowed_oauth_flows_user_pool_client = null
  default_client_write_attributes                     = null
  default_client_explicit_auth_flows                  = null
  default_client_prevent_user_existence_errors        = null
  ```

- **`default_client_callback_urls`**: *(Optional `list(string)`)*

  List of allowed callback URLs for the identity providers.

- **`default_client_default_redirect_uri`**: *(Optional `string`)*

  The default redirect URI. Must be in the list of callback URLs.

- **`default_client_read_attributes`**: *(Optional `list(string)`)*

  List of Cognito User Pool attributes the application client can read from.

- **`default_client_refresh_token_validity`**: *(Optional `number`)*

  The time limit in days refresh tokens are valid for.

- **`default_client_supported_identity_providers`**: *(Optional `list(string)`)*

  List of provider names for the identity providers that are supported on this client.

- **`default_client_allowed_oauth_scopes`**: *(Optional `list(string)`)*

  List of allowed OAuth scopes. Possible values are `phone`, `email`, `openid`, `profile`, and `aws.cognito.signin.user.admin`.

- **`default_client_logout_urls`**: *(Optional `list(string)`)*

  List of allowed logout URLs for the identity providers.

- **`default_client_allowed_oauth_flows_user_pool_client`**: *(Optional `bool`)*

  Whether the client is allowed to follow the OAuth protocol when interacting with Cognito User Pools.

- **`default_client_generate_secret`**: *(Optional `bool`)*

  Boolean flag for generating an application secret.

- **`default_client_allowed_oauth_flows`**: *(Optional `list(string)`)*

  List of allowed OAuth flows. Possible flows are `code`, `implicit`, and `client_credentials`.

- **`default_client_write_attributes`**: *(Optional `list(string)`)*

  List of Cognito User Pool attributes the application client can write to.

- **`default_client_explicit_auth_flows`**: *(Optional `list(string)`)*

  List of authentication flows. Possible values are `ADMIN_NO_SRP_AUTH`, `CUSTOM_AUTH_FLOW_ONLY`, `USER_PASSWORD_AUTH`, `ALLOW_ADMIN_USER_PASSWORD_AUTH`, `ALLOW_CUSTOM_AUTH`, `ALLOW_USER_PASSWORD_AUTH`, `ALLOW_USER_SRP_AUTH`, and `ALLOW_REFRESH_TOKEN_AUTH`.

- **`default_client_prevent_user_existence_errors`**: *(Optional `string`)*

  Choose which errors and responses are returned by Cognito APIs during authentication, account confirmation, and password recovery when the user does not exist in the Cognito User Pool. When set to `ENABLED` and the user does not exist, authentication returns an error indicating either the username or password was incorrect, and account confirmation and password recovery return a response indicating a code was sent to a simulated destination. When set to `LEGACY`, those APIs will return a `UserNotFoundException` exception if the user does not exist in the Cognito User Pool.

## Module Attributes Reference

The following attributes are exported by the module:

- **`user_pool`**: The `cognito_user_pool` object.
- **`clients`**: A list of `cognito_user_pool_client` objects.
- **`client_secrets`**: The secrets for all created `cognito_user_pool_client` resources.

## External Documentation

- AWS Documentation:
  - https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools.html
  - https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-client-apps.html
- Terraform AWS Provider Documentation:
  - https://www.terraform.io/docs/providers/aws/r/cognito_user_pool.html
  - https://www.terraform.io/docs/providers/aws/r/cognito_user_pool_client.html

## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)].

Given a version number `MAJOR.MINOR.PATCH`, we increment the:

1. `MAJOR` version when we make incompatible changes,
2. `MINOR` version when we add functionality in a backwards compatible manner, and
3. `PATCH` version when we make backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version

- Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
- Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)

## About Mineiros

[Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
that solves development, automation and security challenges in cloud infrastructure.

Our vision is to massively reduce time and overhead for teams to manage and
deploy production-grade and secure cloud infrastructure.

We offer commercial support for all of our modules and encourage you to reach out
if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
[Community Slack channel][slack].

## Reporting Issues

We use GitHub [Issues] to track community reported issues and missing features.

## Contributing

Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].

## Makefile Targets

This repository comes with a handy [Makefile].
Run `make help` to see details on each available target.

## License

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE] for full details.

Copyright &copy; 2020 [Mineiros GmbH][homepage]

<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-aws-cognito-user-pool

[hello@mineiros.io]: mailto:hello@mineiros.io
[badge-build]: https://github.com/mineiros-io/terraform-aws-lambda-function/workflows/CI/CD%20Pipeline/badge.svg

[badge-semver]: https://img.shields.io/github/v/tag/mineiros-io/terraform-aws-cognito-user-pool.svg?label=latest&sort=semver
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[badge-terraform]: https://img.shields.io/badge/terraform-0.13%20and%200.12.20+-623CE4.svg?logo=terraform
[badge-slack]: https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack

[build-status]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/actions

[releases-github]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/releases
[releases-terraform]: https://github.com/hashicorp/terraform/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://join.slack.com/t/mineiros-community/shared_invite/zt-ehidestg-aLGoIENLVs6tvwJ11w9WGg

[Terraform]: https://www.terraform.io
[AWS]: https://aws.amazon.com/
[Semantic Versioning (SemVer)]: https://semver.org/

[examples/example/main.tf]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/examples/example/main.tf
[variables.tf]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/variables.tf
[examples/]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/examples
[Issues]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/issues
[LICENSE]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/LICENSE
[Makefile]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/Makefile
[Pull Requests]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/pulls
[Contribution Guidelines]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/CONTRIBUTING.md

[Cognito User Pools]: https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools.html
[attributes docs]: https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-attributes.html
[Terraform AWS Cognito User Pool Client Docs]: https://www.terraform.io/docs/providers/aws/r/cognito_user_pool_client.html
