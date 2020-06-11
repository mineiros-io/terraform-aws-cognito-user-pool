# ------------------------------------------------------------------------------
# OUTPUT CALCULATED VARIABLES (prefer full objects)
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OUTPUT ALL RESOURCES AS FULL OBJECTS
# ------------------------------------------------------------------------------

output "user_pool" {
  description = "The full `aws_cognito_user_pool` object."
  value       = try(aws_cognito_user_pool.user_pool[0], null)
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
