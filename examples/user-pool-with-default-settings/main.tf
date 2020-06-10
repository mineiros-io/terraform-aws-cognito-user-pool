# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# DEPLOY A COGNITO USER POOL
# This example deploys a Cognito User Pool with default settings that are
# defined in the variables.tf file of this module.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ------------------------------------------------------------------------------
# PROVIDER CONFIGURATION
# ------------------------------------------------------------------------------

provider "aws" {
  version = "~> 2.54"
  region  = "us-east-1"
}

# ------------------------------------------------------------------------------
# THE COGNITO USER POOL WITH DEFAULT SETTINGS
# ------------------------------------------------------------------------------

module "cognito_user_pool" {
  source = "git@github.com:mineiros-io/terraform-cognito-user-pool.git?ref=v0.0.1"

  name = "example-userpool"
}
