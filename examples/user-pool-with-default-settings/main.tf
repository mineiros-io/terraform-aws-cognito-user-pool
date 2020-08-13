# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# DEPLOY A COGNITO USER POOL
# This example deploys a Cognito User Pool with default settings that are
# defined in the variables.tf file of this module.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ------------------------------------------------------------------------------
# PROVIDER CONFIGURATION
# ------------------------------------------------------------------------------

provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
}

# ------------------------------------------------------------------------------
# THE COGNITO USER POOL WITH DEFAULT SETTINGS
# ------------------------------------------------------------------------------

module "cognito_user_pool" {
  source  = "mineiros-io/cognito-user-pool/aws"
  version = "~> 0.1.4"

  name = "example-userpool"
}
