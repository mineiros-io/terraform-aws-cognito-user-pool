output "user_pool" {
  description = "The full `aws_cognito_user_pool` object."
  value       = module.cognito_user_pool.user_pool
}
