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
  description = "The name of the user pool."
  default     = "test-pool"
}
variable "schema_attributes" {
  type        = any
  description = "A list of schema attributes of a user pool. You can add a maximum um 25 custom attributes."
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
