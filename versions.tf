# ------------------------------------------------------------------------------
# SET TERRAFORM AND PROVIDER REQUIREMENTS FOR RUNNING THIS MODULE
# ------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.12.20, < 0.15"

  required_providers {
    aws = ">= 3.19, < 4.0"
  }
}
