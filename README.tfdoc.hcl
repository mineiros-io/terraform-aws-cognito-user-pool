header {
  image = "https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg"
  url   = "https://mineiros.io/?ref=terraform-aws-cognito-user-pool"

  badge "build" {
    image = "https://github.com/mineiros-io/terraform-aws-cognito-user-pool/workflows/CI/CD%20Pipeline/badge.svg"
    url   = "https://github.com/mineiros-io/terraform-aws-cognito-user-pool/actions"
    text  = "Build Status"
  }

  badge "semver" {
    image = "https://img.shields.io/github/v/tag/mineiros-io/terraform-aws-cognito-user-pool.svg?label=latest&sort=semver"
    url   = "https://github.com/mineiros-io/terraform-aws-cognito-user-pool/releases"
    text  = "GitHub tag (latest SemVer)"
  }

  badge "terraform" {
    image = "https://img.shields.io/badge/terraform-1.x%20|%200.15%20|%200.14%20|%200.13%20|%200.12.20+-623CE4.svg?logo=terraform"
    url   = "https://github.com/hashicorp/terraform/releases"
    text  = "Terraform Version"
  }

  badge "tf-aws-provider" {
    image = "https://img.shields.io/badge/AWS-3.50+-F8991D.svg?logo=terraform"
    url   = "https://github.com/terraform-providers/terraform-provider-aws/releases"
    text  = "AWS Provider Version"
  }

  badge "slack" {
    image = "https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack"
    url   = "https://mineiros.io/slack"
    text  = "Join Slack"
  }
}

section {
  title   = "terraform-aws-cognito-user-pool"
  toc     = true
  content = <<-END
    A [Terraform] module for deploying and managing
    [Cognito User Pools]
    on [Amazon Web Services (AWS)][AWS].

    *This module supports Terraform v1.x, v0.15, v0.14, v0.13 as well as v0.12.20 and above
    and is compatible with the Terraform AWS provider v3.50 and above.
  END

  section {
    title   = "Module Features"
    content = <<-END
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
    END
  }

  section {
    title   = "Getting Started"
    content = <<-END
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
    END
  }

  section {
    title   = "Module Argument Reference"
    content = <<-END
      See
      [variables.tf](https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/variables.tf)
      and
      [examples/](https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/examples)
      for details and use-cases.
    END

    section {
      title = "Top-level Arguments"

      section {
        title = "Module Configuration"

        variable "module_enabled" {
          type        = bool
          default     = true
          description = <<-END
            Specifies whether resources in the module will be created.
          END
        }

        variable "module_tags" {
          type           = map(string)
          default        = {}
          description    = <<-END
            A map of tags that will be applied to all created resources that accept tags. Tags defined with 'module_tags' can be overwritten by resource-specific tags.
          END
          readme_example = <<-END
            module_tags = {
              environment = "staging"
              team        = "platform"
            }
          END
        }

        variable "module_depends_on" {
          type           = list(dependency)
          description    = <<-END
            A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.
          END
          readme_example = <<-END
            module_depends_on = [
              aws_vpc.vpc
            ]
          END
        }
      }

      section {
        title = "Cognito User Pool"

        variable "name" {
          required    = true
          type        = string
          description = <<-END
            The name of the user pool. Forces new resource.
          END
        }

        variable "advanced_security_mode" {
          type        = string
          default     = "OFF"
          description = <<-END
            The mode for advanced security, must be one of `OFF`, `AUDIT` or `ENFORCED`. Additional pricing applies for Amazon Cognito advanced security features. For details see https://aws.amazon.com/cognito/pricing/.
          END
        }

        variable "alias_attributes" {
          type        = set(string)
          description = <<-END
            Attributes supported as an alias for this user pool. Possible values: `phone_number`, `email`, or `preferred_username`. Conflicts with `username_attributes`. Default applies if `username_attributes` is not set.
          END
        }

        variable "username_attributes" {
          type        = set(string)
          description = <<-END
            Specifies whether `email` addresse or `phone_number` can be specified as usernames when a user signs up. Conflicts with `alias_attributes`.
            Default is to use `alias_attributes`.
          END
        }

        variable "allow_admin_create_user_only" {
          type        = bool
          default     = true
          description = <<-END
            Set to True if only the administrator is allowed to create user profiles. Set to False if users can sign themselves up via an app.
          END
        }

        variable "invite_email_subject" {
          type        = string
          default     = "Your new account."
          description = <<-END
            The message template for email messages.
          END
        }

        variable "invite_email_message" {
          type        = string
          default     = "Your username is {username} and your temporary password is ' {####}'"
          description = <<-END
            The message template for email messages. Must contain `{username}` and `{####}` placeholders, for username and temporary password, respectively.
          END
        }

        variable "invite_sms_message" {
          type        = string
          default     = "Your username is {username} and your temporary password is ' {####}'."
          description = <<-END
            The message template for SMS messages. Must contain `{username}` and `{####}` placeholders, for username and temporary password, respectively.
          END
        }

        variable "auto_verified_attributes" {
          type        = set(string)
          default     = ["email"]
          description = <<-END
            The attributes to be auto-verified. Possible values: `email`, `phone_number`.
          END
        }

        variable "user_device_tracking" {
          type        = string
          default     = "USER_OPT_IN"
          description = <<-END
            Configure tracking of user devices. Set to `OFF` to disable tracking, `ALWAYS` to track all devices or `USER_OPT_IN` to only track when user opts in.
          END
        }

        variable "challenge_required_on_new_device" {
          type        = bool
          default     = true
          description = <<-END
            Indicates whether a challenge is required on a new device. Only applicable to a new device. Only applied when `user_device_tracking` is enabled.
          END
        }

        variable "enable_username_case_sensitivity" {
          type        = bool
          default     = false
          description = <<-END
            Specifies whether username case sensitivity will be applied to all users in the user pool through Cognito APIs.
          END
        }

        variable "email_sending_account" {
          type        = string
          default     = "COGNITO_DEFAULT"
          description = <<-END
            The email delivery method to use. `COGNITO_DEFAULT` for the default email functionality built into Cognito or `DEVELOPER` to use your Amazon SES configuration.
          END
        }

        variable "email_reply_to_address" {
          type        = string
          description = <<-END
            The REPLY-TO email address.
          END
        }

        variable "email_source_arn" {
          type        = string
          description = <<-END
            The ARN of the email source.
          END
        }

        variable "email_from_address" {
          type        = string
          description = <<-END
            Sender’s email address or sender’s name with their email address (e.g. 'john@smith.com' or 'John Smith <john@smith.com>').
          END
        }

        variable "mfa_configuration" {
          type        = string
          default     = "OPTIONAL"
          description = <<-END
            Multi-Factor Authentication (MFA) configuration for the User Pool. Valid values: `ON`, `OFF` or `OPTIONAL`. `ON` and `OPTIONAL` require at least one of `sms_configuration` or `software_token_mfa_configuration` to be configured.
          END
        }

        variable "password_minimum_length" {
          type        = number
          default     = 20
          description = <<-END
            The minimum length of the password policy that you have set.
          END
        }

        variable "password_require_lowercase" {
          type        = bool
          default     = true
          description = <<-END
            Whether you have required users to use at least one lowercase letter in their password.
          END
        }

        variable "password_require_numbers" {
          type        = bool
          default     = true
          description = <<-END
            Whether you have required users to use at least one number in their password.
          END
        }

        variable "password_require_symbols" {
          type        = bool
          default     = true
          description = <<-END
            Whether you have required users to use at least one symbol in their password.
          END
        }

        variable "password_require_uppercase" {
          type        = bool
          default     = true
          description = <<-END
            Whether you have required users to use at least one uppercase letter in their password.
          END
        }

        variable "temporary_password_validity_days" {
          type        = number
          default     = 1
          description = <<-END
            In the password policy you have set, refers to the number of days a temporary password is valid. If the user does not sign in during this time, their password will need to be reset by an administrator.
          END
        }

        variable "allow_software_mfa_token" {
          type        = bool
          default     = true
          description = <<-END
            Boolean whether to enable software token Multi-Factor Authentication (MFA) tokens, such as Time-Based One-Time Password (TOTP). To disable software token MFA when `sms_configuration` is not present, the `mfa_configuration` argument must be set to `OFF` and the `software_token_mfa_configuration` configuration block must be fully removed.
          END
        }

        variable "sms_authentication_message" {
          type        = string
          default     = "Your temporary password is {####}."
          description = <<-END
            A string representing the SMS authentication message. The message must contain the `{####}` placeholder, which will be replaced with the authentication code.
          END
        }

        variable "lambda_create_auth_challenge" {
          type        = string
          description = <<-END
            The ARN of an AWS Lambda creating an authentication challenge.
          END
        }

        variable "lambda_custom_message" {
          type        = string
          description = <<-END
            The ARN of a custom message AWS Lambda trigger.
          END
        }

        variable "lambda_define_auth_challenge" {
          type        = string
          description = <<-END
            The ARN of an AWS Lambda that defines the authentication challenge.
          END
        }

        variable "lambda_post_authentication" {
          type        = string
          description = <<-END
            The ARN of an AWS Lambda that defines the authentication challenge.
          END
        }

        variable "lambda_post_confirmation" {
          type        = string
          description = <<-END
            The ARN of a post-confirmation AWS Lambda trigger.
          END
        }

        variable "lambda_pre_authentication" {
          type        = string
          description = <<-END
            The ARN of a pre-authentication AWS Lambda trigger.
          END
        }

        variable "lambda_pre_sign_up" {
          type        = string
          description = <<-END
            The ARN of a pre-registration AWS Lambda trigger.
          END
        }

        variable "lambda_pre_token_generation" {
          type        = string
          description = <<-END
            The ARN of an AWS Lambda that allows customization of identity token claims before token generation.
          END
        }

        variable "lambda_user_migration" {
          type        = string
          description = <<-END
            The ARN of he user migration AWS Lambda config type.
          END
        }

        variable "lambda_verify_auth_challenge_response" {
          type        = string
          default     = "true"
          description = <<-END
            The ARN of an AWS Lambda that verifies the authentication challenge response.
          END
        }

        variable "schema_attributes" {
          type           = list(schema_attribute)
          default        = []
          description    = <<-END
            A list of schema attributes of a user pool. You can add a maximum of 25 custom attributes. Please note that only default attributes can be marked as required.
            Also an attribute cannot be switched between required and not required after a user pool has been created.
            For details please see the [attributes docs].
          END
          readme_example = <<-END
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
          END
        }

        variable "account_recovery_mechanisms" {
          type           = list(account_recovery_mechanism)
          default        = []
          description    = <<-END
            A list of recovery_mechanisms to be inserted inside `account_recovery_setting`.
          END
          readme_example = <<-END
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
          END

          attribute "name" {
            required    = true
            type        = string
            description = <<-END
              Recovery method for a user. Can be of the following: verified_email, verified_phone_number, and admin_only.
            END
          }

          attribute "priority" {
            required    = true
            type        = string
            description = <<-END
              Positive integer specifying priority of a method with 1 being the highest priority.
            END
          }
        }

        variable "sms_configuration" {
          type        = object(sms_configuration)
          description = <<-END
            The `sms_configuration` with the `external_id` parameter used in IAM role trust relationships and the `sns_caller_arn` parameter to set the ARN of the Amazon SNS caller. This is usually the IAM role that you have given AWS Cognito permission to assume.
          END

          attribute "external_id" {
            required    = true
            type        = string
            description = <<-END
              External ID used in IAM role trust relationships.
            END
          }

          attribute "sns_caller_arn" {
            required    = true
            type        = string
            description = <<-END
              ARN of the Amazon SNS caller. This is usually the IAM role that you've given Cognito permission to assume.
            END
          }
        }

        variable "default_email_option" {
          type        = string
          default     = "CONFIRM_WITH_CODE"
          description = <<-END
            The default email option. Must be either `CONFIRM_WITH_CODE` or `CONFIRM_WITH_LINK`.
          END
        }

        variable "email_message" {
          type        = string
          default     = "Your verification code is {####}."
          description = <<-END
            The email message template. Must contain the `{####}` placeholder.
          END
        }

        variable "email_message_by_link" {
          type        = string
          default     = "Please click the link below to verify your email address.{##Verify Email##}."
          description = <<-END
            The email message template for sending a confirmation link to the user, it must contain the `{##Any Text##}` placeholder.
          END
        }

        variable "email_subject" {
          type        = string
          default     = "Your Verification Code"
          description = <<-END
            The subject line for the email message template.
          END
        }

        variable "email_subject_by_link" {
          type        = string
          default     = "Your Verifiction Link"
          description = <<-END
            The subject line for the email message template for sending a confirmation link to the user.
          END
        }

        variable "sms_message" {
          type        = string
          default     = "Your verification code is {####}."
          description = <<-END
            The SMS message template. Must contain the `{####}` placeholder, which will be replaced with the verification code. Can also contain the `{username}` placeholder which will be replaced with the username.
          END
        }

        variable "tags" {
          type           = map(string)
          default        = {}
          description    = <<-END
            A mapping of tags to assign to the resource.
          END
          readme_example = <<-END
            tags  = {
              CreatedAt = "2020-02-07",
              Alice     = "Bob"
            }
          END
        }
      }

      section {
        title = "Cognito User Pool Domain"

        variable "domain" {
          type        = string
          description = <<-END
            The domain name that should be used. Can be set to a FQDN or prefix.
            If no FQDN and `certificate_arn` are set, the domain prefix will be used for the sign-up and sign-in pages that are hosted by Amazon Cognito,
            e.g. `https://{YOUR_PREFIX}.auth.eu-west-1.amazoncognito.com`.
            The prefix must be unique across the selected AWS Region.
            Domain names can only contain lower-case letters, numbers, and hyphens.
          END
        }

        variable "certificate_arn" {
          type        = string
          description = <<-END
            The ARN of an ISSUED ACM certificate in us-east-1 for a custom domain.
          END
        }
      }

      section {
        title = "Cognito User Pool Resource Servers"

        variable "resource_servers" {
          type           = list(resource_server)
          default        = []
          description    = <<-END
            A list of objects with resource server declarations.
          END
          readme_example = <<-END
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
          END

          attribute "identifier" {
            required    = true
            type        = string
            description = <<-END
              An identifier for the resource server.
            END
          }

          attribute "name" {
            required    = true
            type        = string
            description = <<-END
              A name for the resource server.
            END
          }

          attribute "scope" {
            type        = list(scope)
            description = <<-END
              A list of Authorization Scope.
            END

            attribute "scope_name" {
              required    = true
              type        = string
              description = <<-END
                The scope name.
              END
            }

            attribute "scope_description" {
              required    = true
              type        = string
              description = <<-END
                The scope description.
              END
            }
          }
        }
      }

      section {
        title = "Cognito User Pool Clients"

        variable "clients" {
          type           = list(client)
          default        = []
          description    = <<-END
            A list of objects with the clients definitions.
          END
          readme_example = <<-END
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
          END

          attribute "name" {
            required    = true
            type        = string
            description = <<-END
              Name of the application client.
            END
          }

          attribute "user_pool_id" {
            type        = string
            description = <<-END
              Name of the application client.
            END
          }

          attribute "access_token_validity" {
            type        = number
            description = <<-END
              Time limit, between 5 minutes and 1 day, after which the access token is no longer valid and cannot be used. This value will be overridden if you have entered a value in token_validity_units.
            END
          }

          attribute "allowed_oauth_flows_user_pool_client" {
            type        = bool
            description = <<-END
              Whether the client is allowed to follow the OAuth protocol when interacting with Cognito user pools.
            END
          }

          attribute "allowed_oauth_flows" {
            type        = set(string)
            description = <<-END
              List of allowed OAuth flows (code, implicit, client_credentials).
            END
          }

          attribute "allowed_oauth_scopes" {
            type        = set(string)
            description = <<-END
              List of allowed OAuth scopes (phone, email, openid, profile, and aws.cognito.signin.user.admin).
            END
          }

          attribute "analytics_configuration" {
            type        = object(analytics_configuration)
            description = <<-END
              Configuration block for Amazon Pinpoint analytics for collecting metrics for this user pool.
            END

            attribute "application_arn" {
              type        = string
              description = <<-END
                Application ARN for an Amazon Pinpoint application. Conflicts with external_id and role_arn.
              END
            }

            attribute "application_id" {
              type        = string
              description = <<-END
                Application ID for an Amazon Pinpoint application.
              END
            }

            attribute "external_id" {
              type        = string
              description = <<-END
                ID for the Analytics Configuration. Conflicts with application_arn. Application ID for an Amazon Pinpoint application.
              END
            }

            attribute "role_arn" {
              type        = string
              description = <<-END
                ARN of an IAM role that authorizes Amazon Cognito to publish events to Amazon Pinpoint analytics. Conflicts with application_arn.
              END
            }

            attribute "user_data_shared" {
              type        = bool
              description = <<-END
                If set to true, Amazon Cognito will include user data in the events it publishes to Amazon Pinpoint analytics.
              END
            }
          }

          attribute "callback_urls" {
            type        = set(string)
            description = <<-END
              List of allowed callback URLs for the identity providers.
            END
          }

          attribute "default_redirect_uri" {
            type        = string
            description = <<-END
              Default redirect URI. Must be in the list of callback URLs.
            END
          }

          attribute "enable_token_revocation" {
            type        = bool
            description = <<-END
              Enables or disables token revocation.
            END
          }

          attribute "explicit_auth_flows" {
            type        = set(string)
            description = <<-END
              List of authentication flows (ADMIN_NO_SRP_AUTH, CUSTOM_AUTH_FLOW_ONLY, USER_PASSWORD_AUTH, ALLOW_ADMIN_USER_PASSWORD_AUTH, ALLOW_CUSTOM_AUTH, ALLOW_USER_PASSWORD_AUTH, ALLOW_USER_SRP_AUTH, ALLOW_REFRESH_TOKEN_AUTH).
            END
          }

          attribute "generate_secret" {
            type        = bool
            description = <<-END
              Should an application secret be generated.
            END
          }

          attribute "id_token_validity" {
            type        = number
            description = <<-END
              Time limit, between 5 minutes and 1 day, after which the ID token is no longer valid and cannot be used. This value will be overridden if you have entered a value in token_validity_units.
            END
          }

          attribute "logout_urls" {
            type        = set(string)
            description = <<-END
              List of allowed logout URLs for the identity providers.
            END
          }

          attribute "prevent_user_existence_errors" {
            type        = string
            description = <<-END
              Choose which errors and responses are returned by Cognito APIs during authentication, account confirmation, and password recovery when the user does not exist in the user pool. When set to ENABLED and the user does not exist, authentication returns an error indicating either the username or password was incorrect, and account confirmation and password recovery return a response indicating a code was sent to a simulated destination. When set to LEGACY, those APIs will return a UserNotFoundException exception if the user does not exist in the user pool.
            END
          }

          attribute "read_attributes" {
            type        = set(string)
            description = <<-END
              List of user pool attributes the application client can read from.
            END
          }

          attribute "refresh_token_validity" {
            type        = number
            description = <<-END
              Time limit in days refresh tokens are valid for.
            END
          }

          attribute "supported_identity_providers" {
            type        = set(string)
            description = <<-END
              List of provider names for the identity providers that are supported on this client. Uses the provider_name attribute of aws_cognito_identity_provider resource(s), or the equivalent string(s).
            END
          }

          attribute "token_validity_units" {
            type        = object(token_validity_units)
            description = <<-END
              Configuration block for units in which the validity times are represented in.
            END

            attribute "access_token" {
              type        = string
              default     = "hours"
              description = <<-END
                Time unit in for the value in access_token_validity, defaults to hours.
              END
            }

            attribute "id_token" {
              type        = string
              default     = "hours"
              description = <<-END
                Time unit in for the value in id_token_validity, defaults to hours.
              END
            }

            attribute "refresh_token" {
              type        = string
              default     = "days"
              description = <<-END
                Time unit in for the value in refresh_token_validity, defaults to days.
              END
            }
          }

          attribute "write_attributes" {
            type        = set(string)
            description = <<-END
              List of user pool attributes the application client can write to.
            END
          }
        }
      }

      section {
        title   = "Cognito User Pool Clients Default Values"
        content = <<-END
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
        END

        variable "default_client_callback_urls" {
          type        = list(string)
          description = <<-END
            List of allowed callback URLs for the identity providers.
          END
        }

        variable "default_client_default_redirect_uri" {
          type        = string
          description = <<-END
            The default redirect URI. Must be in the list of callback URLs.
          END
        }

        variable "default_client_read_attributes" {
          type        = list(string)
          description = <<-END
            List of Cognito User Pool attributes the application client can read from.
          END
        }

        variable "default_client_refresh_token_validity" {
          type        = number
          description = <<-END
            The time limit in days refresh tokens are valid for.
          END
          default     = 30
        }

        variable "default_client_supported_identity_providers" {
          type        = list(string)
          description = <<-END
            List of provider names for the identity providers that are supported on this client.
          END
        }

        variable "default_client_allowed_oauth_scopes" {
          type        = list(string)
          description = <<-END
            List of allowed OAuth scopes. Possible values are `phone`, `email`, `openid`, `profile`, and `aws.cognito.signin.user.admin`.
          END
        }

        variable "default_client_logout_urls" {
          type        = list(string)
          description = <<-END
            List of allowed logout URLs for the identity providers.
          END
        }

        variable "default_client_allowed_oauth_flows_user_pool_client" {
          type        = bool
          description = <<-END
            Whether the client is allowed to follow the OAuth protocol when interacting with Cognito User Pools.
          END
        }

        variable "default_client_generate_secret" {
          type        = bool
          description = <<-END
            Boolean flag for generating an application secret.
          END
        }

        variable "default_client_allowed_oauth_flows" {
          type        = list(string)
          description = <<-END
            List of allowed OAuth flows. Possible flows are `code`, `implicit`, and `client_credentials`.
          END
        }

        variable "default_client_write_attributes" {
          type        = list(string)
          description = <<-END
            List of Cognito User Pool attributes the application client can write to.
          END
        }

        variable "default_client_explicit_auth_flows" {
          type        = list(string)
          description = <<-END
            List of authentication flows. Possible values are `ADMIN_NO_SRP_AUTH`, `CUSTOM_AUTH_FLOW_ONLY`, `USER_PASSWORD_AUTH`, `ALLOW_ADMIN_USER_PASSWORD_AUTH`, `ALLOW_CUSTOM_AUTH`, `ALLOW_USER_PASSWORD_AUTH`, `ALLOW_USER_SRP_AUTH`, and `ALLOW_REFRESH_TOKEN_AUTH`.
          END
        }

        variable "default_client_prevent_user_existence_errors" {
          type        = string
          description = <<-END
            Choose which errors and responses are returned by Cognito APIs during authentication, account confirmation, and password recovery when the user does not exist in the Cognito User Pool. When set to `ENABLED` and the user does not exist, authentication returns an error indicating either the username or password was incorrect, and account confirmation and password recovery return a response indicating a code was sent to a simulated destination. When set to `LEGACY`, those APIs will return a `UserNotFoundException` exception if the user does not exist in the Cognito User Pool.
          END
        }

        variable "default_client_access_token_validity" {
          type        = number
          description = <<-END
            Time limit, between 5 minutes and 1 day, after which the access token is no longer valid and cannot be used. 
            This value will be overridden if you have entered a value in 'default_client_token_validity_units'.
          END
        }

        variable "default_client_id_token_validity" {
          type        = number
          description = <<-END
            Time limit, between 5 minutes and 1 day, after which the ID token is no longer valid and cannot be used. 
            This value will be overridden if you have entered a value in 'default_client_token_validity_units'.
          END
        }

        variable "default_client_token_validity_units" {
          type        = number
          description = <<-END
            Configuration block for units in which the validity times are represented in.
          END
        }

        variable "default_client_enable_token_revocation" {
          type        = bool
          description = <<-END
            Enables or disables token revocation.
          END
        }
      }
    }
  }

  section {
    title   = "Module Outputs"
    content = <<-END
      The following attributes are exported by the module:
    END

    output "user_pool" {
      type        = object(user_pool)
      description = <<-END
        The `cognito_user_pool` object.
      END
    }

    output "domain" {
      type        = object(domain)
      description = <<-END
        The full `aws_cognito_user_pool` object.
      END
    }

    output "clients" {
      type        = map(client)
      description = <<-END
        A map of `cognito_user_pool_client` objects. The map is keyed by the
        `name` of the created clients. Client secrets are filtered out of this
        map and are available through the `client_secrets` output variable and
        flagged as sensitive.
      END
    }

    output "client_secrets" {
      type        = map(client_secret)
      description = <<-END
        A sensitive map of client secrets for all created
        `cognito_user_pool_client` resources. The map is keyed by the `name` of
        the created clients.
      END
    }

    output "module_enabled" {
      type        = bool
      description = <<-END
        Whether this module is enabled.
      END
    }
  }

  section {
    title = "External Documentation"

    section {
      title = "AWS Documentation"

      content = <<-END
        - https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools.html
        - https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-client-apps.html
      END
    }

    section {
      title = "Terraform AWS Provider Documentation"

      content = <<-END
        - User Pool - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool
        - User Pool Client - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client
        - User Pool Domain - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain
        - Resource Server - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_resource_server
      END
    }
  }

  section {
    title   = "Module Versioning"
    content = <<-END
      This Module follows the principles of [Semantic Versioning (SemVer)].

      Given a version number `MAJOR.MINOR.PATCH`, we increment the:

      1. `MAJOR` version when we make incompatible changes,
      2. `MINOR` version when we add functionality in a backwards compatible manner, and
      3. `PATCH` version when we make backwards compatible bug fixes.
    END

    section {
      title   = "Backwards compatibility in `0.0.z` and `0.y.z` version"
      content = <<-END
        - Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
        - Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)
      END
    }
  }

  section {
    title   = "About Mineiros"
    content = <<-END
      [Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
      that solves development, automation and security challenges in cloud infrastructure.

      Our vision is to massively reduce time and overhead for teams to manage and
      deploy production-grade and secure cloud infrastructure.

      We offer commercial support for all of our modules and encourage you to reach out
      if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
      [Community Slack channel][slack].
    END
  }

  section {
    title   = "Reporting Issues"
    content = <<-END
      We use GitHub [Issues] to track community reported issues and missing features.
    END
  }

  section {
    title   = "Contributing"
    content = <<-END
      Contributions are always encouraged and welcome! For the process of accepting changes, we use
      [Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].
    END
  }

  section {
    title   = "Makefile Targets"
    content = <<-END
      This repository comes with a handy [Makefile].
      Run `make help` to see details on each available target.
    END
  }

  section {
    title   = "License"
    content = <<-END
      [![license][badge-license]][apache20]

      This module is licensed under the Apache License Version 2.0, January 2004.
      Please see [LICENSE] for full details.

      Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]
    END
  }
}

references {
  ref "homepage" {
    value = "https://mineiros.io/?ref=terraform-aws-cognito-user-pool"
  }
  ref "mineiros-library" {
    value = "https://www.mineiros.io/solutions/terraform-library"
  }
  ref "mineiros-pricing" {
    value = "https://www.mineiros.io/solutions/terraform-library#pricing"
  }
  ref "hello@mineiros.io" {
    value = "mailto:hello@mineiros.io"
  }
  ref "badge-build" {
    value = "https://github.com/mineiros-io/terraform-aws-lambda-function/workflows/CI/CD%20Pipeline/badge.svg"
  }
  ref "badge-semver" {
    value = "https://img.shields.io/github/v/tag/mineiros-io/terraform-aws-cognito-user-pool.svg?label=latest&sort=semver"
  }
  ref "badge-license" {
    value = "https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg"
  }
  ref "badge-terraform" {
    value = "https://img.shields.io/badge/terraform-1.x%20|%200.15%20|%200.14%20|%200.13%20|%200.12.20+-623CE4.svg?logo=terraform"
  }
  ref "badge-slack" {
    value = "https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack"
  }
  ref "build-status" {
    value = "https://github.com/mineiros-io/terraform-aws-cognito-user-pool/actions"
  }
  ref "badge-tf-aws" {
    value = "https://img.shields.io/badge/AWS-3.19+-F8991D.svg?logo=terraform"
  }
  ref "releases-aws-provider" {
    value = "https://github.com/terraform-providers/terraform-provider-aws/releases"
  }
  ref "releases-github" {
    value = "https://github.com/mineiros-io/terraform-aws-cognito-user-pool/releases"
  }
  ref "releases-terraform" {
    value = "https://github.com/hashicorp/terraform/releases"
  }
  ref "apache20" {
    value = "https://opensource.org/licenses/Apache-2.0"
  }
  ref "slack" {
    value = "https://join.slack.com/t/mineiros-community/shared_invite/zt-ehidestg-aLGoIENLVs6tvwJ11w9WGg"
  }
  ref "Terraform" {
    value = "https://www.terraform.io"
  }
  ref "AWS" {
    value = "https://aws.amazon.com/"
  }
  ref "Semantic Versioning (SemVer)" {
    value = "https://semver.org/"
  }
  ref "examples/example/main.tf" {
    value = "https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/examples/example/main.tf"
  }
  ref "variables.tf" {
    value = "https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/variables.tf"
  }
  ref "examples/" {
    value = "https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/examples"
  }
  ref "Issues" {
    value = "https://github.com/mineiros-io/terraform-aws-cognito-user-pool/issues"
  }
  ref "LICENSE" {
    value = "https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/LICENSE"
  }
  ref "Makefile" {
    value = "https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/Makefile"
  }
  ref "Pull Requests" {
    value = "https://github.com/mineiros-io/terraform-aws-cognito-user-pool/pulls"
  }
  ref "Contribution Guidelines" {
    value = "https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/CONTRIBUTING.md"
  }
  ref "Cognito User Pools" {
    value = "https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools.html"
  }
  ref "attributes docs" {
    value = "https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-attributes.html"
  }
  ref "Terraform AWS Cognito User Pool Client Docs" {
    value = "https://www.terraform.io/docs/providers/aws/r/cognito_user_pool_client.html"
  }
  ref "Terraform AWS Cognito Resource Server Docs" {
    value = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_resource_server"
  }
}
