# ------------------------------------------------------------------------------
# Example Setup
# ------------------------------------------------------------------------------

provider "aws" {
  version = "~> 2.0"
}

# ------------------------------------------------------------------------------
# Example Usage
# ------------------------------------------------------------------------------

module "cognito_user_pool" {
  source = "../../"
  name   = "test-userpool"

  //  sms_configuration = {
  //    external_id    = "1234"
  //    sns_caller_arn = "arn:aws:sns:eu-west-1:999999999999:dev-sns-topic"
  //  }

  lambda_create_auth_challenge = "arn:aws:lambda:eu-west-1:815481169901:function:sns-to-slack"

  schema_attributes = [
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
}
