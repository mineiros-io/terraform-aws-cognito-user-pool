# ------------------------------------------------------------------------------
# OUTPUT CALCULATED VARIABLES (prefer full objects)
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OUTPUT ALL RESOURCES AS FULL OBJECTS
# ------------------------------------------------------------------------------

output "user_pool" {
  description = "All outputs exposed by the module."
  value       = merge(module.cognito_user_pool, { client_secrets = null })
  sensitive   = true
}

output "client_secrets" {
  description = "The secrets of all created Cognito User Pool Client resources."
  value       = module.cognito_user_pool.client_secrets
  sensitive   = true
}

# ------------------------------------------------------------------------------
# OUTPUT ALL INPUT VARIABLES
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OUTPUT MODULE CONFIGURATION
# ------------------------------------------------------------------------------
