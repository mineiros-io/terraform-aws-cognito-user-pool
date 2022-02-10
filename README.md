[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>](https://mineiros.io/?ref=terraform-aws-cognito-user-pool)

[![Build Status](https://github.com/mineiros-io/terraform-aws-cognito-user-pool/workflows/CI/CD%20Pipeline/badge.svg)](https://github.com/mineiros-io/terraform-aws-cognito-user-pool/actions)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/terraform-aws-cognito-user-pool.svg?label=latest&sort=semver)](https://github.com/mineiros-io/terraform-aws-cognito-user-pool/releases)
[![Terraform Version](https://img.shields.io/badge/terraform-1.x%20|%200.15%20|%200.14%20|%200.13%20|%200.12.20+-623CE4.svg?logo=terraform)](https://github.com/hashicorp/terraform/releases)
[![AWS Provider Version](https://img.shields.io/badge/AWS-3.50+-F8991D.svg?logo=terraform)](https://github.com/terraform-providers/terraform-provider-aws/releases)
[![Join Slack](https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack)](https://mineiros.io/slack)

# terraform-aws-cognito-user-pool

A [Terraform] module for deploying and managing
[Cognito User Pools]
on [Amazon Web Services (AWS)][AWS].

*This module supports Terraform v1.x, v0.15, v0.14, v0.13 as well as v0.12.20 and above
and is compatible with the Terraform AWS provider v3.50 and above.


- [Module Features](#module-features)
- [Getting Started](#getting-started)
- [Module Argument Reference](#module-argument-reference)
  - [Top-level Arguments](#top-level-arguments)
    - [Module Configuration](#module-configuration)
    - [Cognito User Pool](#cognito-user-pool)
    - [Cognito User Pool Domain](#cognito-user-pool-domain)
    - [Cognito User Pool Resource Servers](#cognito-user-pool-resource-servers)
    - [Cognito User Pool Clients](#cognito-user-pool-clients)
    - [Cognito User Pool Clients Default Values](#cognito-user-pool-clients-default-values)
- [Module Outputs](#module-outputs)
- [External Documentation](#external-documentation)
  - [AWS Documentation](#aws-documentation)
  - [Terraform AWS Provider Documentation](#terraform-aws-provider-documentation)
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
  Create Cognito User Pool Resource Servers as associated scopes.

- *Features not yet implemented*:
  [`cognito_user_group`](https://www.terraform.io/docs/providers/aws/r/cognito_user_group.html)

## Getting Started

Most basic usage just setting required arguments:

```hcl
module "terraform-aws-cognito-user-pool" {
  source  = "mineiros-io/cognito-user-pool/aws"
  version = "~> 0.9.0"

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

- [**`module_enabled`**](#var-module_enabled): *(Optional `bool`)*<a name="var-module_enabled"></a>

  Specifies whether resources in the module will be created.

  Default is `true`.

- [**`module_tags`**](#var-module_tags): *(Optional `map(string)`)*<a name="var-module_tags"></a>

  A map of tags that will be applied to all created resources that accept tags. Tags defined with 'module_tags' can be overwritten by resource-specific tags.

  Default is `{}`.

  Example:

  ```hcl
  module_tags = {
    environment = "staging"
    team        = "platform"
  }
  ```

- [**`module_depends_on`**](#var-module_depends_on): *(Optional `list(dependency)`)*<a name="var-module_depends_on"></a>

  A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.

  Example:

  ```hcl
  module_depends_on = [
    aws_vpc.vpc
  ]
  ```

#### Cognito User Pool

- [**`name`**](#var-name): *(**Required** `string`)*<a name="var-name"></a>

  The name of the user pool. Forces new resource.

- [**`advanced_security_mode`**](#var-advanced_security_mode): *(Optional `string`)*<a name="var-advanced_security_mode"></a>

  The mode for advanced security, must be one of `OFF`, `AUDIT` or `ENFORCED`. Additional pricing applies for Amazon Cognito advanced security features. For details see https://aws.amazon.com/cognito/pricing/.

  Default is `"OFF"`.

- [**`alias_attributes`**](#var-alias_attributes): *(Optional `set(string)`)*<a name="var-alias_attributes"></a>

  Attributes supported as an alias for this user pool. Possible values: `phone_number`, `email`, or `preferred_username`. Conflicts with `username_attributes`. Default applies if `username_attributes` is not set.

- [**`username_attributes`**](#var-username_attributes): *(Optional `set(string)`)*<a name="var-username_attributes"></a>

  Specifies whether `email` addresse or `phone_number` can be specified as usernames when a user signs up. Conflicts with `alias_attributes`.
  Default is to use `alias_attributes`.

- [**`allow_admin_create_user_only`**](#var-allow_admin_create_user_only): *(Optional `bool`)*<a name="var-allow_admin_create_user_only"></a>

  Set to True if only the administrator is allowed to create user profiles. Set to False if users can sign themselves up via an app.

  Default is `true`.

- [**`invite_email_subject`**](#var-invite_email_subject): *(Optional `string`)*<a name="var-invite_email_subject"></a>

  The message template for email messages.

  Default is `"Your new account."`.

- [**`invite_email_message`**](#var-invite_email_message): *(Optional `string`)*<a name="var-invite_email_message"></a>

  The message template for email messages. Must contain `{username}` and `{####}` placeholders, for username and temporary password, respectively.

  Default is `"Your username is {username} and your temporary password is ' {####}'"`.

- [**`invite_sms_message`**](#var-invite_sms_message): *(Optional `string`)*<a name="var-invite_sms_message"></a>

  The message template for SMS messages. Must contain `{username}` and `{####}` placeholders, for username and temporary password, respectively.

  Default is `"Your username is {username} and your temporary password is ' {####}'."`.

- [**`auto_verified_attributes`**](#var-auto_verified_attributes): *(Optional `set(string)`)*<a name="var-auto_verified_attributes"></a>

  The attributes to be auto-verified. Possible values: `email`, `phone_number`.

  Default is `["email"]`.

- [**`user_device_tracking`**](#var-user_device_tracking): *(Optional `string`)*<a name="var-user_device_tracking"></a>

  Configure tracking of user devices. Set to `OFF` to disable tracking, `ALWAYS` to track all devices or `USER_OPT_IN` to only track when user opts in.

  Default is `"USER_OPT_IN"`.

- [**`challenge_required_on_new_device`**](#var-challenge_required_on_new_device): *(Optional `bool`)*<a name="var-challenge_required_on_new_device"></a>

  Indicates whether a challenge is required on a new device. Only applicable to a new device. Only applied when `user_device_tracking` is enabled.

  Default is `true`.

- [**`enable_username_case_sensitivity`**](#var-enable_username_case_sensitivity): *(Optional `bool`)*<a name="var-enable_username_case_sensitivity"></a>

  Specifies whether username case sensitivity will be applied to all users in the user pool through Cognito APIs.

  Default is `false`.

- [**`email_sending_account`**](#var-email_sending_account): *(Optional `string`)*<a name="var-email_sending_account"></a>

  The email delivery method to use. `COGNITO_DEFAULT` for the default email functionality built into Cognito or `DEVELOPER` to use your Amazon SES configuration.

  Default is `"COGNITO_DEFAULT"`.

- [**`email_reply_to_address`**](#var-email_reply_to_address): *(Optional `string`)*<a name="var-email_reply_to_address"></a>

  The REPLY-TO email address.

- [**`email_source_arn`**](#var-email_source_arn): *(Optional `string`)*<a name="var-email_source_arn"></a>

  The ARN of the email source.

- [**`email_from_address`**](#var-email_from_address): *(Optional `string`)*<a name="var-email_from_address"></a>

  Sender’s email address or sender’s name with their email address (e.g. 'john@smith.com' or 'John Smith <john@smith.com>').

- [**`mfa_configuration`**](#var-mfa_configuration): *(Optional `string`)*<a name="var-mfa_configuration"></a>

  Multi-Factor Authentication (MFA) configuration for the User Pool. Valid values: `ON`, `OFF` or `OPTIONAL`. `ON` and `OPTIONAL` require at least one of `sms_configuration` or `software_token_mfa_configuration` to be configured.

  Default is `"OPTIONAL"`.

- [**`password_minimum_length`**](#var-password_minimum_length): *(Optional `number`)*<a name="var-password_minimum_length"></a>

  The minimum length of the password policy that you have set.

  Default is `20`.

- [**`password_require_lowercase`**](#var-password_require_lowercase): *(Optional `bool`)*<a name="var-password_require_lowercase"></a>

  Whether you have required users to use at least one lowercase letter in their password.

  Default is `true`.

- [**`password_require_numbers`**](#var-password_require_numbers): *(Optional `bool`)*<a name="var-password_require_numbers"></a>

  Whether you have required users to use at least one number in their password.

  Default is `true`.

- [**`password_require_symbols`**](#var-password_require_symbols): *(Optional `bool`)*<a name="var-password_require_symbols"></a>

  Whether you have required users to use at least one symbol in their password.

  Default is `true`.

- [**`password_require_uppercase`**](#var-password_require_uppercase): *(Optional `bool`)*<a name="var-password_require_uppercase"></a>

  Whether you have required users to use at least one uppercase letter in their password.

  Default is `true`.

- [**`temporary_password_validity_days`**](#var-temporary_password_validity_days): *(Optional `number`)*<a name="var-temporary_password_validity_days"></a>

  In the password policy you have set, refers to the number of days a temporary password is valid. If the user does not sign in during this time, their password will need to be reset by an administrator.

  Default is `1`.

- [**`allow_software_mfa_token`**](#var-allow_software_mfa_token): *(Optional `bool`)*<a name="var-allow_software_mfa_token"></a>

  Boolean whether to enable software token Multi-Factor Authentication (MFA) tokens, such as Time-Based One-Time Password (TOTP). To disable software token MFA when `sms_configuration` is not present, the `mfa_configuration` argument must be set to `OFF` and the `software_token_mfa_configuration` configuration block must be fully removed.

  Default is `true`.

- [**`sms_authentication_message`**](#var-sms_authentication_message): *(Optional `string`)*<a name="var-sms_authentication_message"></a>

  A string representing the SMS authentication message. The message must contain the `{####}` placeholder, which will be replaced with the authentication code.

  Default is `"Your temporary password is {####}."`.

- [**`lambda_create_auth_challenge`**](#var-lambda_create_auth_challenge): *(Optional `string`)*<a name="var-lambda_create_auth_challenge"></a>

  The ARN of an AWS Lambda creating an authentication challenge.

- [**`lambda_custom_message`**](#var-lambda_custom_message): *(Optional `string`)*<a name="var-lambda_custom_message"></a>

  The ARN of a custom message AWS Lambda trigger.

- [**`lambda_define_auth_challenge`**](#var-lambda_define_auth_challenge): *(Optional `string`)*<a name="var-lambda_define_auth_challenge"></a>

  The ARN of an AWS Lambda that defines the authentication challenge.

- [**`lambda_post_authentication`**](#var-lambda_post_authentication): *(Optional `string`)*<a name="var-lambda_post_authentication"></a>

  The ARN of an AWS Lambda that defines the authentication challenge.

- [**`lambda_post_confirmation`**](#var-lambda_post_confirmation): *(Optional `string`)*<a name="var-lambda_post_confirmation"></a>

  The ARN of a post-confirmation AWS Lambda trigger.

- [**`lambda_pre_authentication`**](#var-lambda_pre_authentication): *(Optional `string`)*<a name="var-lambda_pre_authentication"></a>

  The ARN of a pre-authentication AWS Lambda trigger.

- [**`lambda_pre_sign_up`**](#var-lambda_pre_sign_up): *(Optional `string`)*<a name="var-lambda_pre_sign_up"></a>

  The ARN of a pre-registration AWS Lambda trigger.

- [**`lambda_pre_token_generation`**](#var-lambda_pre_token_generation): *(Optional `string`)*<a name="var-lambda_pre_token_generation"></a>

  The ARN of an AWS Lambda that allows customization of identity token claims before token generation.

- [**`lambda_user_migration`**](#var-lambda_user_migration): *(Optional `string`)*<a name="var-lambda_user_migration"></a>

  The ARN of he user migration AWS Lambda config type.

- [**`lambda_verify_auth_challenge_response`**](#var-lambda_verify_auth_challenge_response): *(Optional `string`)*<a name="var-lambda_verify_auth_challenge_response"></a>

  The ARN of an AWS Lambda that verifies the authentication challenge response.

  Default is `"true"`.

- [**`schema_attributes`**](#var-schema_attributes): *(Optional `list(schema_attribute)`)*<a name="var-schema_attributes"></a>

  A list of schema attributes of a user pool. You can add a maximum of 25 custom attributes. Please note that only default attributes can be marked as required.
  Also an attribute cannot be switched between required and not required after a user pool has been created.
  For details please see the [attributes docs].

  Default is `[]`.

  Example:

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

- [**`account_recovery_mechanisms`**](#var-account_recovery_mechanisms): *(Optional `list(account_recovery_mechanism)`)*<a name="var-account_recovery_mechanisms"></a>

  A list of recovery_mechanisms to be inserted inside `account_recovery_setting`.

  Default is `[]`.

  Example:

  ```hcl
  account_recovery_mechanisms = [
    {
      name     = "verified_email"
      priority = 1
    },
    {
      name     = "verified_phone_number"
      priority = 2
    }
  ]
  ```

  Each `account_recovery_mechanism` object in the list accepts the following attributes:

  - [**`name`**](#attr-account_recovery_mechanisms-name): *(**Required** `string`)*<a name="attr-account_recovery_mechanisms-name"></a>

    Recovery method for a user. Can be of the following: verified_email, verified_phone_number, and admin_only.

  - [**`priority`**](#attr-account_recovery_mechanisms-priority): *(**Required** `string`)*<a name="attr-account_recovery_mechanisms-priority"></a>

    Positive integer specifying priority of a method with 1 being the highest priority.

- [**`sms_configuration`**](#var-sms_configuration): *(Optional `object(sms_configuration)`)*<a name="var-sms_configuration"></a>

  The `sms_configuration` with the `external_id` parameter used in IAM role trust relationships and the `sns_caller_arn` parameter to set the ARN of the Amazon SNS caller. This is usually the IAM role that you have given AWS Cognito permission to assume.

  The `sms_configuration` object accepts the following attributes:

  - [**`external_id`**](#attr-sms_configuration-external_id): *(**Required** `string`)*<a name="attr-sms_configuration-external_id"></a>

    External ID used in IAM role trust relationships.

  - [**`sns_caller_arn`**](#attr-sms_configuration-sns_caller_arn): *(**Required** `string`)*<a name="attr-sms_configuration-sns_caller_arn"></a>

    ARN of the Amazon SNS caller. This is usually the IAM role that you've given Cognito permission to assume.

- [**`default_email_option`**](#var-default_email_option): *(Optional `string`)*<a name="var-default_email_option"></a>

  The default email option. Must be either `CONFIRM_WITH_CODE` or `CONFIRM_WITH_LINK`.

  Default is `"CONFIRM_WITH_CODE"`.

- [**`email_message`**](#var-email_message): *(Optional `string`)*<a name="var-email_message"></a>

  The email message template. Must contain the `{####}` placeholder.

  Default is `"Your verification code is {####}."`.

- [**`email_message_by_link`**](#var-email_message_by_link): *(Optional `string`)*<a name="var-email_message_by_link"></a>

  The email message template for sending a confirmation link to the user, it must contain the `{##Any Text##}` placeholder.

  Default is `"Please click the link below to verify your email address.{##Verify Email##}."`.

- [**`email_subject`**](#var-email_subject): *(Optional `string`)*<a name="var-email_subject"></a>

  The subject line for the email message template.

  Default is `"Your Verification Code"`.

- [**`email_subject_by_link`**](#var-email_subject_by_link): *(Optional `string`)*<a name="var-email_subject_by_link"></a>

  The subject line for the email message template for sending a confirmation link to the user.

  Default is `"Your Verifiction Link"`.

- [**`sms_message`**](#var-sms_message): *(Optional `string`)*<a name="var-sms_message"></a>

  The SMS message template. Must contain the `{####}` placeholder, which will be replaced with the verification code. Can also contain the `{username}` placeholder which will be replaced with the username.

  Default is `"Your verification code is {####}."`.

- [**`tags`**](#var-tags): *(Optional `map(string)`)*<a name="var-tags"></a>

  A mapping of tags to assign to the resource.

  Default is `{}`.

  Example:

  ```hcl
  tags  = {
    CreatedAt = "2020-02-07",
    Alice     = "Bob"
  }
  ```

#### Cognito User Pool Domain

- [**`domain`**](#var-domain): *(Optional `string`)*<a name="var-domain"></a>

  The domain name that should be used. Can be set to a FQDN or prefix.
  If no FQDN and `certificate_arn` are set, the domain prefix will be used for the sign-up and sign-in pages that are hosted by Amazon Cognito,
  e.g. `https://{YOUR_PREFIX}.auth.eu-west-1.amazoncognito.com`.
  The prefix must be unique across the selected AWS Region.
  Domain names can only contain lower-case letters, numbers, and hyphens.

- [**`certificate_arn`**](#var-certificate_arn): *(Optional `string`)*<a name="var-certificate_arn"></a>

  The ARN of an ISSUED ACM certificate in us-east-1 for a custom domain.

#### Cognito User Pool Resource Servers

- [**`resource_servers`**](#var-resource_servers): *(Optional `list(resource_server)`)*<a name="var-resource_servers"></a>

  A list of objects with resource server declarations.

  Default is `[]`.

  Example:

  ```hcl
  resource_servers = [
    {
      identifier = "https://api.resourceserver.com"
      name       = "API"
      scopes     = [
        {
          scope_name = "users:read"
          scope_description = "Read user data"
        },
        {
          scope_name = "users:write"
          scope_description = "Write user data"
        }
      ]
    }
  ]
  ```

  Each `resource_server` object in the list accepts the following attributes:

  - [**`identifier`**](#attr-resource_servers-identifier): *(**Required** `string`)*<a name="attr-resource_servers-identifier"></a>

    An identifier for the resource server.

  - [**`name`**](#attr-resource_servers-name): *(**Required** `string`)*<a name="attr-resource_servers-name"></a>

    A name for the resource server.

  - [**`scope`**](#attr-resource_servers-scope): *(Optional `list(scope)`)*<a name="attr-resource_servers-scope"></a>

    A list of Authorization Scope.

    Each `scope` object in the list accepts the following attributes:

    - [**`scope_name`**](#attr-resource_servers-scope-scope_name): *(**Required** `string`)*<a name="attr-resource_servers-scope-scope_name"></a>

      The scope name.

    - [**`scope_description`**](#attr-resource_servers-scope-scope_description): *(**Required** `string`)*<a name="attr-resource_servers-scope-scope_description"></a>

      The scope description.

#### Cognito User Pool Clients

- [**`clients`**](#var-clients): *(Optional `list(client)`)*<a name="var-clients"></a>

  A list of objects with the clients definitions.

  Default is `[]`.

  Example:

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

  Each `client` object in the list accepts the following attributes:

  - [**`name`**](#attr-clients-name): *(**Required** `string`)*<a name="attr-clients-name"></a>

    Name of the application client.

  - [**`user_pool_id`**](#attr-clients-user_pool_id): *(Optional `string`)*<a name="attr-clients-user_pool_id"></a>

    Name of the application client.

  - [**`access_token_validity`**](#attr-clients-access_token_validity): *(Optional `number`)*<a name="attr-clients-access_token_validity"></a>

    Time limit, between 5 minutes and 1 day, after which the access token is no longer valid and cannot be used. This value will be overridden if you have entered a value in token_validity_units.

  - [**`allowed_oauth_flows_user_pool_client`**](#attr-clients-allowed_oauth_flows_user_pool_client): *(Optional `bool`)*<a name="attr-clients-allowed_oauth_flows_user_pool_client"></a>

    Whether the client is allowed to follow the OAuth protocol when interacting with Cognito user pools.

  - [**`allowed_oauth_flows`**](#attr-clients-allowed_oauth_flows): *(Optional `set(string)`)*<a name="attr-clients-allowed_oauth_flows"></a>

    List of allowed OAuth flows (code, implicit, client_credentials).

  - [**`allowed_oauth_scopes`**](#attr-clients-allowed_oauth_scopes): *(Optional `set(string)`)*<a name="attr-clients-allowed_oauth_scopes"></a>

    List of allowed OAuth scopes (phone, email, openid, profile, and aws.cognito.signin.user.admin).

  - [**`analytics_configuration`**](#attr-clients-analytics_configuration): *(Optional `object(analytics_configuration)`)*<a name="attr-clients-analytics_configuration"></a>

    Configuration block for Amazon Pinpoint analytics for collecting metrics for this user pool.

    The `analytics_configuration` object accepts the following attributes:

    - [**`application_arn`**](#attr-clients-analytics_configuration-application_arn): *(Optional `string`)*<a name="attr-clients-analytics_configuration-application_arn"></a>

      Application ARN for an Amazon Pinpoint application. Conflicts with external_id and role_arn.

    - [**`application_id`**](#attr-clients-analytics_configuration-application_id): *(Optional `string`)*<a name="attr-clients-analytics_configuration-application_id"></a>

      Application ID for an Amazon Pinpoint application.

    - [**`external_id`**](#attr-clients-analytics_configuration-external_id): *(Optional `string`)*<a name="attr-clients-analytics_configuration-external_id"></a>

      ID for the Analytics Configuration. Conflicts with application_arn. Application ID for an Amazon Pinpoint application.

    - [**`role_arn`**](#attr-clients-analytics_configuration-role_arn): *(Optional `string`)*<a name="attr-clients-analytics_configuration-role_arn"></a>

      ARN of an IAM role that authorizes Amazon Cognito to publish events to Amazon Pinpoint analytics. Conflicts with application_arn.

    - [**`user_data_shared`**](#attr-clients-analytics_configuration-user_data_shared): *(Optional `bool`)*<a name="attr-clients-analytics_configuration-user_data_shared"></a>

      If set to true, Amazon Cognito will include user data in the events it publishes to Amazon Pinpoint analytics.

  - [**`callback_urls`**](#attr-clients-callback_urls): *(Optional `set(string)`)*<a name="attr-clients-callback_urls"></a>

    List of allowed callback URLs for the identity providers.

  - [**`default_redirect_uri`**](#attr-clients-default_redirect_uri): *(Optional `string`)*<a name="attr-clients-default_redirect_uri"></a>

    Default redirect URI. Must be in the list of callback URLs.

  - [**`enable_token_revocation`**](#attr-clients-enable_token_revocation): *(Optional `bool`)*<a name="attr-clients-enable_token_revocation"></a>

    Enables or disables token revocation.

  - [**`explicit_auth_flows`**](#attr-clients-explicit_auth_flows): *(Optional `set(string)`)*<a name="attr-clients-explicit_auth_flows"></a>

    List of authentication flows (ADMIN_NO_SRP_AUTH, CUSTOM_AUTH_FLOW_ONLY, USER_PASSWORD_AUTH, ALLOW_ADMIN_USER_PASSWORD_AUTH, ALLOW_CUSTOM_AUTH, ALLOW_USER_PASSWORD_AUTH, ALLOW_USER_SRP_AUTH, ALLOW_REFRESH_TOKEN_AUTH).

  - [**`generate_secret`**](#attr-clients-generate_secret): *(Optional `bool`)*<a name="attr-clients-generate_secret"></a>

    Should an application secret be generated.

  - [**`id_token_validity`**](#attr-clients-id_token_validity): *(Optional `number`)*<a name="attr-clients-id_token_validity"></a>

    Time limit, between 5 minutes and 1 day, after which the ID token is no longer valid and cannot be used. This value will be overridden if you have entered a value in token_validity_units.

  - [**`logout_urls`**](#attr-clients-logout_urls): *(Optional `set(string)`)*<a name="attr-clients-logout_urls"></a>

    List of allowed logout URLs for the identity providers.

  - [**`prevent_user_existence_errors`**](#attr-clients-prevent_user_existence_errors): *(Optional `string`)*<a name="attr-clients-prevent_user_existence_errors"></a>

    Choose which errors and responses are returned by Cognito APIs during authentication, account confirmation, and password recovery when the user does not exist in the user pool. When set to ENABLED and the user does not exist, authentication returns an error indicating either the username or password was incorrect, and account confirmation and password recovery return a response indicating a code was sent to a simulated destination. When set to LEGACY, those APIs will return a UserNotFoundException exception if the user does not exist in the user pool.

  - [**`read_attributes`**](#attr-clients-read_attributes): *(Optional `set(string)`)*<a name="attr-clients-read_attributes"></a>

    List of user pool attributes the application client can read from.

  - [**`refresh_token_validity`**](#attr-clients-refresh_token_validity): *(Optional `number`)*<a name="attr-clients-refresh_token_validity"></a>

    Time limit in days refresh tokens are valid for.

  - [**`supported_identity_providers`**](#attr-clients-supported_identity_providers): *(Optional `set(string)`)*<a name="attr-clients-supported_identity_providers"></a>

    List of provider names for the identity providers that are supported on this client. Uses the provider_name attribute of aws_cognito_identity_provider resource(s), or the equivalent string(s).

  - [**`token_validity_units`**](#attr-clients-token_validity_units): *(Optional `object(token_validity_units)`)*<a name="attr-clients-token_validity_units"></a>

    Configuration block for units in which the validity times are represented in.

    The `token_validity_units` object accepts the following attributes:

    - [**`access_token`**](#attr-clients-token_validity_units-access_token): *(Optional `string`)*<a name="attr-clients-token_validity_units-access_token"></a>

      Time unit in for the value in access_token_validity, defaults to hours.

      Default is `"hours"`.

    - [**`id_token`**](#attr-clients-token_validity_units-id_token): *(Optional `string`)*<a name="attr-clients-token_validity_units-id_token"></a>

      Time unit in for the value in id_token_validity, defaults to hours.

      Default is `"hours"`.

    - [**`refresh_token`**](#attr-clients-token_validity_units-refresh_token): *(Optional `string`)*<a name="attr-clients-token_validity_units-refresh_token"></a>

      Time unit in for the value in refresh_token_validity, defaults to days.

      Default is `"days"`.

  - [**`write_attributes`**](#attr-clients-write_attributes): *(Optional `set(string)`)*<a name="attr-clients-write_attributes"></a>

    List of user pool attributes the application client can write to.

#### Cognito User Pool Clients Default Values

The following variables can be used for setting default settings among various clients defined through the `clients` variable. This helps you to quickly issue several clients that implement the same settings, e.g. like so:

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
default_client_access_token_validity                = null
default_client_id_token_validity                    = null
default_client_token_validity_units                 = null
default_client_enable_token_revocation              = null
```

- [**`default_client_callback_urls`**](#var-default_client_callback_urls): *(Optional `list(string)`)*<a name="var-default_client_callback_urls"></a>

  List of allowed callback URLs for the identity providers.

- [**`default_client_default_redirect_uri`**](#var-default_client_default_redirect_uri): *(Optional `string`)*<a name="var-default_client_default_redirect_uri"></a>

  The default redirect URI. Must be in the list of callback URLs.

- [**`default_client_read_attributes`**](#var-default_client_read_attributes): *(Optional `list(string)`)*<a name="var-default_client_read_attributes"></a>

  List of Cognito User Pool attributes the application client can read from.

- [**`default_client_refresh_token_validity`**](#var-default_client_refresh_token_validity): *(Optional `number`)*<a name="var-default_client_refresh_token_validity"></a>

  The time limit in days refresh tokens are valid for.

  Default is `30`.

- [**`default_client_supported_identity_providers`**](#var-default_client_supported_identity_providers): *(Optional `list(string)`)*<a name="var-default_client_supported_identity_providers"></a>

  List of provider names for the identity providers that are supported on this client.

- [**`default_client_allowed_oauth_scopes`**](#var-default_client_allowed_oauth_scopes): *(Optional `list(string)`)*<a name="var-default_client_allowed_oauth_scopes"></a>

  List of allowed OAuth scopes. Possible values are `phone`, `email`, `openid`, `profile`, and `aws.cognito.signin.user.admin`.

- [**`default_client_logout_urls`**](#var-default_client_logout_urls): *(Optional `list(string)`)*<a name="var-default_client_logout_urls"></a>

  List of allowed logout URLs for the identity providers.

- [**`default_client_allowed_oauth_flows_user_pool_client`**](#var-default_client_allowed_oauth_flows_user_pool_client): *(Optional `bool`)*<a name="var-default_client_allowed_oauth_flows_user_pool_client"></a>

  Whether the client is allowed to follow the OAuth protocol when interacting with Cognito User Pools.

- [**`default_client_generate_secret`**](#var-default_client_generate_secret): *(Optional `bool`)*<a name="var-default_client_generate_secret"></a>

  Boolean flag for generating an application secret.

- [**`default_client_allowed_oauth_flows`**](#var-default_client_allowed_oauth_flows): *(Optional `list(string)`)*<a name="var-default_client_allowed_oauth_flows"></a>

  List of allowed OAuth flows. Possible flows are `code`, `implicit`, and `client_credentials`.

- [**`default_client_write_attributes`**](#var-default_client_write_attributes): *(Optional `list(string)`)*<a name="var-default_client_write_attributes"></a>

  List of Cognito User Pool attributes the application client can write to.

- [**`default_client_explicit_auth_flows`**](#var-default_client_explicit_auth_flows): *(Optional `list(string)`)*<a name="var-default_client_explicit_auth_flows"></a>

  List of authentication flows. Possible values are `ADMIN_NO_SRP_AUTH`, `CUSTOM_AUTH_FLOW_ONLY`, `USER_PASSWORD_AUTH`, `ALLOW_ADMIN_USER_PASSWORD_AUTH`, `ALLOW_CUSTOM_AUTH`, `ALLOW_USER_PASSWORD_AUTH`, `ALLOW_USER_SRP_AUTH`, and `ALLOW_REFRESH_TOKEN_AUTH`.

- [**`default_client_prevent_user_existence_errors`**](#var-default_client_prevent_user_existence_errors): *(Optional `string`)*<a name="var-default_client_prevent_user_existence_errors"></a>

  Choose which errors and responses are returned by Cognito APIs during authentication, account confirmation, and password recovery when the user does not exist in the Cognito User Pool. When set to `ENABLED` and the user does not exist, authentication returns an error indicating either the username or password was incorrect, and account confirmation and password recovery return a response indicating a code was sent to a simulated destination. When set to `LEGACY`, those APIs will return a `UserNotFoundException` exception if the user does not exist in the Cognito User Pool.

- [**`default_client_access_token_validity`**](#var-default_client_access_token_validity): *(Optional `number`)*<a name="var-default_client_access_token_validity"></a>

  Time limit, between 5 minutes and 1 day, after which the access token is no longer valid and cannot be used. 
  This value will be overridden if you have entered a value in 'default_client_token_validity_units'.

- [**`default_client_id_token_validity`**](#var-default_client_id_token_validity): *(Optional `number`)*<a name="var-default_client_id_token_validity"></a>

  Time limit, between 5 minutes and 1 day, after which the ID token is no longer valid and cannot be used. 
  This value will be overridden if you have entered a value in 'default_client_token_validity_units'.

- [**`default_client_token_validity_units`**](#var-default_client_token_validity_units): *(Optional `number`)*<a name="var-default_client_token_validity_units"></a>

  Configuration block for units in which the validity times are represented in.

- [**`default_client_enable_token_revocation`**](#var-default_client_enable_token_revocation): *(Optional `bool`)*<a name="var-default_client_enable_token_revocation"></a>

  Enables or disables token revocation.

## Module Outputs

The following attributes are exported by the module:

- [**`user_pool`**](#output-user_pool): *(`object(user_pool)`)*<a name="output-user_pool"></a>

  The `cognito_user_pool` object.

- [**`domain`**](#output-domain): *(`object(domain)`)*<a name="output-domain"></a>

  The full `aws_cognito_user_pool` object.

- [**`clients`**](#output-clients): *(`map(client)`)*<a name="output-clients"></a>

  A map of `cognito_user_pool_client` objects. The map is keyed by the
  `name` of the created clients. Client secrets are filtered out of this
  map and are available through the `client_secrets` output variable and
  flagged as sensitive.

- [**`client_secrets`**](#output-client_secrets): *(`map(client_secret)`)*<a name="output-client_secrets"></a>

  A sensitive map of client secrets for all created
  `cognito_user_pool_client` resources. The map is keyed by the `name` of
  the created clients.

- [**`module_enabled`**](#output-module_enabled): *(`bool`)*<a name="output-module_enabled"></a>

  Whether this module is enabled.

## External Documentation

### AWS Documentation

- https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools.html
- https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-client-apps.html

### Terraform AWS Provider Documentation

- User Pool - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool
- User Pool Client - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client
- User Pool Domain - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain
- Resource Server - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_resource_server

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

[![license][badge-license]][apache20]

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE] for full details.

Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]


<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-aws-cognito-user-pool
[mineiros-library]: https://www.mineiros.io/solutions/terraform-library
[mineiros-pricing]: https://www.mineiros.io/solutions/terraform-library#pricing
[hello@mineiros.io]: mailto:hello@mineiros.io
[badge-build]: https://github.com/mineiros-io/terraform-aws-lambda-function/workflows/CI/CD%20Pipeline/badge.svg
[badge-semver]: https://img.shields.io/github/v/tag/mineiros-io/terraform-aws-cognito-user-pool.svg?label=latest&sort=semver
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[badge-terraform]: https://img.shields.io/badge/terraform-1.x%20|%200.15%20|%200.14%20|%200.13%20|%200.12.20+-623CE4.svg?logo=terraform
[badge-slack]: https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack
[build-status]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/actions
[badge-tf-aws]: https://img.shields.io/badge/AWS-3.19+-F8991D.svg?logo=terraform
[releases-aws-provider]: https://github.com/terraform-providers/terraform-provider-aws/releases
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
[Terraform AWS Cognito Resource Server Docs]: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_resource_server
