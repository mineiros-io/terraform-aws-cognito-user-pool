# ------------------------------------------------------------------------------
# OUTPUT CALCULATED VARIABLES (prefer full objects)
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OUTPUT ALL RESOURCES AS FULL OBJECTS
# ------------------------------------------------------------------------------

# fix tf13 output diff
locals {
  user_pool = try(aws_cognito_user_pool.user_pool[0], {})

  o_user_pool_tags = try(local.user_pool.tags, {})

  o_user_pool = var.module_enabled ? merge(local.user_pool, {
    tags = local.o_user_pool_tags != null ? local.user_pool.tags : {}
  }) : null
}


output "user_pool" {
  description = "The full `aws_cognito_user_pool` object."
  value       = local.o_user_pool
}

output "domain" {
  description = "The full `aws_cognito_user_pool` object."
  value       = try(aws_cognito_user_pool_domain.domain[0], null)
}

output "clients" {
  description = "All Cognito User Pool Client resources associated with the Cognito User Pool."
  value       = { for client in aws_cognito_user_pool_client.client : client.name => merge(client, { client_secret = null }) }
}

output "client_secrets" {
  description = "The secrets of all created Cognito User Pool Client resources."
  value       = { for client in aws_cognito_user_pool_client.client : client.name => client.client_secret }
  sensitive   = true
}

# ------------------------------------------------------------------------------
# OUTPUT ALL INPUT VARIABLES
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OUTPUT MODULE CONFIGURATION
# ------------------------------------------------------------------------------

output "module_enabled" {
  description = "Whether the module is enabled"
  value       = var.module_enabled
}
