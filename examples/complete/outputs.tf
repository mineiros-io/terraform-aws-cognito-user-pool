output "user_pool" {
  description = "All outputs exposed by the module."
  value       = merge(module.cognito_user_pool, { client_secrets = null })
}

output "clients" {
  description = "All Cognito User Pool Client resources associated with the Cognito User Pool."
  value       = { for client in module.cognito_user_pool.clients : client.name => merge(client, { client_secret = null }) }
}

output "client_secrets" {
  description = "The secrets of all created Cognito User Pool Client resources."
  value       = module.cognito_user_pool.client_secrets
  sensitive   = true
}
