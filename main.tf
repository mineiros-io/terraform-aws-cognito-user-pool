# ------------------------------------------------------------------------------
# DEPLOY A COGNITO USER POOL
# This module deploys a Amazon Web Servics (AWS) Cognito User Pool Service.
# Cognito user pools are used for authentication and act as identity provider.
# With a user pool, your app users can sign in through the user pool or
# federate through a third-party identity provider (idP). For more information
# please see:
# https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools.html
# ------------------------------------------------------------------------------

resource "aws_cognito_user_pool" "user_pool" {
  count = var.module_enabled ? 1 : 0

  name                     = var.name
  alias_attributes         = var.alias_attributes
  auto_verified_attributes = var.auto_verified_attributes

  sms_authentication_message = var.sms_authentication_message

  mfa_configuration = var.mfa_configuration

  password_policy {
    minimum_length                   = var.password_minimum_length
    require_lowercase                = var.password_require_lowercase
    require_numbers                  = var.password_require_numbers
    require_symbols                  = var.password_require_symbols
    require_uppercase                = var.password_require_uppercase
    temporary_password_validity_days = var.temporary_password_validity_days
  }

  device_configuration {
    challenge_required_on_new_device      = var.challenge_required_on_new_device
    device_only_remembered_on_user_prompt = var.device_only_remembered_on_user_prompt
  }

  dynamic software_token_mfa_configuration {
    for_each = var.allow_software_mfa_token ? [true] : []

    content {
      enabled = true
    }
  }

  username_configuration {
    case_sensitive = var.enable_username_case_sensitivity
  }

  email_configuration {
    email_sending_account  = var.email_sending_account
    reply_to_email_address = var.email_reply_to_address
    source_arn             = var.email_source_arn
    from_email_address     = var.email_from_address
  }

  # The configuration for AdminCreateUser
  # https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_AdminCreateUser.html.
  admin_create_user_config {
    allow_admin_create_user_only = var.allow_admin_create_user_only

    invite_message_template {
      email_subject = var.invite_email_subject
      email_message = var.invite_email_message
      sms_message   = var.invite_sms_message
    }
  }

  dynamic schema {
    for_each = var.schema_attributes
    iterator = attribute

    content {
      name                     = attribute.value.name
      required                 = try(attribute.value.required, false)
      attribute_data_type      = attribute.value.type
      developer_only_attribute = try(attribute.value.developer_only_attribute, false)
      mutable                  = try(attribute.value.mutable, true)

      dynamic number_attribute_constraints {
        for_each = try(coalesce(
          lookup(attribute.value, "min_value", null),
          lookup(attribute.value, "max_value", null)
        ), null) == null ? [] : [true]

        content {
          min_value = lookup(attribute.value, "min_value", null)
          max_value = lookup(attribute.value, "max_value", null)
        }
      }

      dynamic string_attribute_constraints {
        for_each = try(coalesce(
          lookup(attribute.value, "min_length", null),
          lookup(attribute.value, "max_length", null)
        ), null) == null ? [] : [true]

        content {
          min_length = lookup(attribute.value, "min_length", null)
          max_length = lookup(attribute.value, "max_length", null)
        }
      }

    }
  }

  dynamic lambda_config {
    for_each = try(coalesce(
      var.lambda_create_auth_challenge,
      var.lambda_custom_message,
      var.lambda_define_auth_challenge,
      var.lambda_post_authentication,
      var.lambda_post_confirmation,
      var.lambda_pre_authentication,
      var.lambda_pre_sign_up,
      var.lambda_pre_token_generation,
      var.lambda_user_migration,
      var.lambda_verify_auth_challenge_response
    ), null) == null ? [] : [true]

    content {
      create_auth_challenge          = var.lambda_create_auth_challenge
      custom_message                 = var.lambda_custom_message
      define_auth_challenge          = var.lambda_define_auth_challenge
      post_authentication            = var.lambda_post_authentication
      post_confirmation              = var.lambda_post_confirmation
      pre_authentication             = var.lambda_pre_authentication
      pre_sign_up                    = var.lambda_pre_sign_up
      pre_token_generation           = var.lambda_pre_token_generation
      user_migration                 = var.lambda_user_migration
      verify_auth_challenge_response = var.lambda_verify_auth_challenge_response
    }
  }

  # Configuration block for Short Message Service (SMS) settings.
  # These settings apply to SMS user verification and SMS Multi-Factor Authentication (MFA).
  # Due to Cognito API restrictions, the SMS configuration cannot be removed without recreating the Cognito User Pool.
  # For user data safety, this resource will ignore the removal of this configuration by disabling drift detection.
  # To force resource recreation after this configuration has been applied, see the taint command.
  dynamic sms_configuration {
    for_each = var.sms_configuration != null ? [var.sms_configuration] : []

    content {
      external_id    = lookup(var.sms_configuration, "external_id", null)
      sns_caller_arn = lookup(var.sms_configuration, "sns_caller_arn", null)
    }
  }

  # Advanced Security Features
  # Note: Additional pricing applies for Amazon Cognito advanced security features. For details please see:
  # https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-settings-advanced-security.html
  user_pool_add_ons {
    advanced_security_mode = var.advanced_security_mode
  }

  verification_message_template {
    default_email_option  = var.default_email_option
    email_subject         = var.email_subject
    email_message         = var.email_message
    email_subject_by_link = var.email_subject_by_link
    email_message_by_link = var.email_message_by_link
    sms_message           = var.sms_message
  }

  tags       = var.tags
  depends_on = [var.module_depends_on]
}
