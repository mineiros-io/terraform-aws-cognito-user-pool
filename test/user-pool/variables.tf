# ------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables.
# ------------------------------------------------------------------------------

# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY

variable "aws_region" {
  description = "The AWS region to deploy the example in."
  type        = string
  default     = "us-east-1"
}

# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables must be set when using this module.
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These variables have defaults, but may be overridden.
# ------------------------------------------------------------------------------

variable "name" {
  type        = string
  description = "The name of the Cognito User Pool."
  default     = "test-pool"
}

variable "domain" {
  type        = string
  description = "The domain name that should be used. Can be set to a FQDN or prefix."
  default     = "mineiros-test"
}

variable "resource_servers" {
  description = "(Optional) A list of objects with resource server definitions."
  type        = any
  default = [
    {
      identifier = "https://api.resourceserver.com"
      name       = "API"
      scopes = [
        {
          scope_name        = "users:read",
          scope_description = "Read user data"
        },
        {
          scope_name        = "users:write"
          scope_description = "Write user data"
        }
      ]
    }
  ]
}

variable "clients" {
  description = "(Optional) A list of objects with the clients definitions."
  type        = any
  default = [
    {
      name                 = "android-mobile-client"
      read_attributes      = ["email", "email_verified", "preferred_username"]
      allowed_oauth_scopes = ["email", "openid", "https://api.resourceserver.com/users:read"]
      allowed_oauth_flows  = ["implicit"]
      callback_urls        = ["https://mineiros.io/callback", "https://mineiros.io/anothercallback"]
      default_redirect_uri = "https://mineiros.io/callback"
      generate_secret      = true
    }
  ]
}

variable "schema_attributes" {
  type        = any
  description = "A list of schema attributes of a Cognito User Pool. You can add a maximum um 25 custom attributes."
  default = [
    {
      # overwrite the default attribute 'gender'
      name     = "gender",
      type     = "String"
      required = true
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
    },
  ]
}
