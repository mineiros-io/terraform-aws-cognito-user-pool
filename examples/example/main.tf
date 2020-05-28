# ------------------------------------------------------------------------------
# Example full usage of the terraform-module-template module
# ------------------------------------------------------------------------------

module "terraform-module-template" {
  source = "git@github.com:mineiros-io/terraform-module-template.git?ref=v0.0.1"

  # All required module arguments

  # none

  # All optional module arguments set to the default values

  # none

  # All optional module configuration arguments set to the default values.
  # Those are maintained for terraform 0.12 but can still be used in terraform 0.13
  # Starting with terraform 0.13 you can additionally make use of module level
  # count, for_each and depends_on features.
  module_enabled    = true
  module_depends_on = []
}

# ------------------------------------------------------------------------------
# Example AWS provider setup
# ------------------------------------------------------------------------------

provider "aws" {
  version = "~> 2.0"
}

# ------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES:
# ------------------------------------------------------------------------------
# You can provide your credentials via the
#   AWS_ACCESS_KEY_ID and
#   AWS_SECRET_ACCESS_KEY, environment variables,
# representing your AWS Access Key and AWS Secret Key, respectively.
# Note that setting your AWS credentials using either these (or legacy)
# environment variables will override the use of
#   AWS_SHARED_CREDENTIALS_FILE and
#   AWS_PROFILE.
# The
#   AWS_DEFAULT_REGION and
#   AWS_SESSION_TOKEN environment variables are also used, if applicable.
# ------------------------------------------------------------------------------
