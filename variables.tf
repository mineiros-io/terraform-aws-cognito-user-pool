# ------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables.
# ------------------------------------------------------------------------------

# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY

# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables must be set when using this module.
# ------------------------------------------------------------------------------

variable "name" {
  type        = string
  description = "(Required) The name of the user pool."
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These variables have defaults, but may be overridden.
# ------------------------------------------------------------------------------

variable "advanced_security_mode" {
  type        = string
  description = "(Optional) The mode for advanced security, must be one of `OFF`, `AUDIT` or `ENFORCED`. Additional pricing applies for Amazon Cognito advanced security features. For details see https://aws.amazon.com/cognito/pricing/"
  default     = "OFF"
}

variable "alias_attributes" {
  type        = set(string)
  description = "(Optional) Attributes supported as an alias for this user pool. Possible values: 'phone_number', 'email', or 'preferred_username'. Conflicts with username_attributes."
  default = [
    "email",
    "preferred_username",
  ]
}

variable "allow_admin_create_user_only" {
  type        = bool
  description = "(Optional) Set to True if only the administrator is allowed to create user profiles. Set to False if users can sign themselves up via an app."
  default     = true
}

variable "invite_email_subject" {
  type        = string
  description = "(Optional) The message template for email messages."
  default     = "Your verification code"
}

variable "invite_email_message" {
  type        = string
  description = "(Optional) The message template for email messages. Must contain {username} and {####} placeholders, for username and temporary password, respectively."
  default     = "Your username is {username} and your temporary password is '{####}'."
}

variable "invite_sms_message" {
  type        = string
  description = "(Optional) The message template for SMS messages. Must contain {username} and {####} placeholders, for username and temporary password, respectively."
  default     = "Your username is {username} and your temporary password is '{####}'."
}

variable "auto_verified_attributes" {
  type        = set(string)
  description = "(Optional) The attributes to be auto-verified. Possible values: 'email', 'phone_number'."
  default = [
    "email"
  ]
}

variable "challenge_required_on_new_device" {
  type        = bool
  description = "(Optional) Indicates whether a challenge is required on a new device. Only applicable to a new device."
  default     = true
}

variable "device_only_remembered_on_user_prompt" {
  type        = bool
  description = "(Optional) If true, a device is only remembered on user prompt."
  default     = true
}

variable "enable_username_case_sensitivity" {
  type        = bool
  description = "(Optional) Specifies whether username case sensitivity will be applied for all users in the user pool through Cognito APIs."
  default     = false
}

variable "email_sending_account" {
  type        = string
  description = "(Optional) Instruct Cognito to either use its built-in functional or Amazon SES to send out emails."
  default     = "COGNITO_DEFAULT"
}

variable "email_reply_to_address" {
  type        = string
  description = "(Optional) - The REPLY-TO email address."
  default     = null
}

variable "email_source_arn" {
  type        = string
  description = "(Optional) - The ARN of the email source."
  default     = null
}

variable "email_from_address" {
  type        = string
  description = "(Optional) - Sender’s email address or sender’s name with their email address (e.g. 'john@smith.com' or 'John Smith <john@smith.com>')."
  default     = null
}

variable "mfa_configuration" {
  type        = string
  description = "Multi-Factor Authentication (MFA) configuration for the User Pool. Valid values: 'ON', 'OFF' or 'OPTIONAL'. 'ON' and 'OPTIONAL' require at least one of 'sms_configuration' or 'software_token_mfa_configuration' to be configured."
  default     = "OPTIONAL"
}

variable "minimum_length" {
  type        = number
  description = "(Optional) The minimum length of the password policy that you have set."
  default     = 20
}

variable "require_lowercase" {
  type        = bool
  description = "(Optional) Whether you have required users to use at least one lowercase letter in their password."
  default     = true
}

variable "require_numbers" {
  type        = bool
  description = "(Optional) Whether you have required users to use at least one number in their password."
  default     = true
}

variable "require_symbols" {
  type        = bool
  description = "(Optional) Whether you have required users to use at least one symbol in their password."
  default     = true
}

variable "require_uppercase" {
  type        = bool
  description = "(Optional) Whether you have required users to use at least one uppercase letter in their password."
  default     = true
}

variable "temporary_password_validity_days" {
  type        = number
  description = "(Optional) In the password policy you have set, refers to the number of days a temporary password is valid. If the user does not sign-in during this time, their password will need to be reset by an administrator."
  default     = 1
}

variable "allow_software_mfa_token" {
  description = "(Optional) Boolean whether to enable software token Multi-Factor (MFA) tokens, such as Time-based One-Time Password (TOTP). To disable software token MFA when 'sms_configuration' is not present, the 'mfa_configuration' argument must be set to OFF and the 'software_token_mfa_configuration' configuration block must be fully removed."
  type        = bool
  default     = true
}

variable "sms_authentication_message" {
  type        = string
  description = "(Optional) A string representing the SMS authentication message. The message must contain the {####} placeholder, which will be replaced with the authentication code."
  default     = "Your temporary password is {####}."
}

variable "lambda_create_auth_challenge" {
  type        = string
  description = "(Optional) - The ARN of the lambda creating an authentication challenge."
  default     = null
}

variable "lambda_custom_message" {
  type        = string
  description = "(Optional) - A custom Message AWS Lambda trigger."
  default     = null
}

variable "lambda_define_auth_challenge" {
  type        = string
  description = "(Optional) - Defines the authentication challenge."
  default     = null
}

variable "lambda_post_authentication" {
  type        = string
  description = "(Optional) - A post-authentication AWS Lambda trigger."
  default     = null
}

variable "lambda_post_confirmation" {
  type        = string
  description = "(Optional) - A post-confirmation AWS Lambda trigger."
  default     = null
}

variable "lambda_pre_authentication" {
  type        = string
  description = "(Optional) - A pre-authentication AWS Lambda trigger."
  default     = null
}

variable "lambda_pre_sign_up" {
  type        = string
  description = "(Optional) - A pre-registration AWS Lambda trigger."
  default     = null
}

variable "lambda_pre_token_generation" {
  type        = string
  description = "(Optional) - Allow to customize identity token claims before token generation."
  default     = null
}

variable "lambda_user_migration" {
  type        = string
  description = "(Optional) - The user migration Lambda config type."
  default     = null
}

variable "lambda_verify_auth_challenge_response" {
  type        = string
  description = "(Optional) - Verifies the authentication challenge response."
  default     = null
}

variable "schema_attributes" {
  description = "(Optional) A list of schema attributes of a user pool. You can add a maximum um 25 custom attributes."
  type        = any

  # Example:
  #
  # schema_attributes = [
  #   {
  #     name                     = "alternative_name"
  #     type                     = "String"
  #     developer_only_attribute = false,
  #     mutable                  = true,
  #     required                 = false,
  #     min_length               = 0,
  #     max_length               = 2048
  #   },
  #   {
  #     name      = "friends_count"
  #     type      = "Number"
  #     min_value = 0,
  #     max_value = 100
  #
  #    },
  #    {
  #
  #      name = "is_active"
  #      type = "Boolean"
  #
  #    },
  #    {
  #      name = "last_seen"
  #      type = "DateTime"
  #
  #    }
  #  ]

  default = []
}

variable "sms_configuration" {
  description = "(Optional) The `sms_configuration` with the `external_id` parameter used in iam role trust relationships and the `sns_caller_arn` parameter to set he arn of the amazon sns caller. this is usually the iam role that you've given cognito permission to assume."
  type = object({
    # The external ID used in IAM role trust relationships. For more information about using external IDs, see https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-user_externalid.html
    external_id = string
    # The ARN of the Amazon SNS caller. This is usually the IAM role that you've given Cognito permission to assume.
    sns_caller_arn = string
  })
  default = null
}

variable "default_email_option" {
  type        = string
  description = "(Optional) The default email option. Must be either `CONFIRM_WITH_CODE` or `CONFIRM_WITH_LINK`."
  default     = "CONFIRM_WITH_CODE"
}

variable "email_message" {
  type        = string
  description = "(Optional) The email message template. Must contain the {####} placeholder."
  default     = "Your verification code is {####}."
}

variable "email_message_by_link" {
  type        = string
  description = "(Optional) The email message template for sending a confirmation link to the user, it must contain the {##Click Here##} placeholder."
  default     = "Please click the link below to verify your email address. {##Verify Email##}."
}

variable "email_subject" {
  type        = string
  description = "(Optional) The subject line for the email message template."
  default     = "Your Verification Code"
}

variable "email_subject_by_link" {
  type        = string
  description = "(Optional) The subject line for the email message template for sending a confirmation link to the user."
  default     = "Your Verification Link"
}

variable "sms_message" {
  type        = string
  description = "(Optional) The SMS message template. Must contain the {####} placeholder, which will be replaced with the verification code. Can also contain the {username} placeholder which will be replaced with the username."
  default     = "Your verification code is {####}."
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."

  #
  # Example:
  #
  # tags = {
  #   CreatedAt = "2020-02-07",
  #   Alice     = "Bob
  # }
  #

  default = {}
}

# ------------------------------------------------------------------------------
# OPTIONAL MODULE CONFIGURATION PARAMETERS
# These variables are used to configure the module.
# See https://medium.com/mineiros/the-ultimate-guide-on-how-to-write-terraform-modules-part-1-81f86d31f024
# ------------------------------------------------------------------------------

variable "module_enabled" {
  type        = bool
  description = "(Optional) Whether to create resources within the module or not. Default is true."
  default     = true
}

variable "module_depends_on" {
  type        = list(any)
  description = "(Optional) A list of external resources the module depends_on. Default is []."
  default     = []
}
