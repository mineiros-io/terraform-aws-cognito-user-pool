# ---------------------------------------------------------------------------------------------------------------------
# CREATE AN AWS COGNITO USER POOL
# This example creates an AWS Cognito User Pool that can be used for authentication (identify verification).
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# PROVIDER CONFIGURATION
# ---------------------------------------------------------------------------------------------------------------------

provider "aws" {
  region = var.aws_region
}

# ------------------------------------------------------------------------------
# CREATE THE COGNITO USER POOL
# ------------------------------------------------------------------------------

module "cognito_user_pool" {
  source = "../../"
  name   = var.name
  domain = var.domain

  schema_attributes = var.schema_attributes
  clients           = var.clients
  resource_servers  = var.resource_servers
}
