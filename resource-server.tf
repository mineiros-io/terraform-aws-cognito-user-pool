resource "aws_cognito_resource_server" "resource_server" {
  for_each = { for resource in var.resource_servers :
    resource.identifier => {
      name   = try(resource.name, null)
      scopes = try(resource.scopes, [])
    }
    if can(resource.identifier)
  }

  identifier   = each.key
  name         = each.value.name
  user_pool_id = aws_cognito_user_pool.user_pool[0].id

  dynamic "scope" {
    for_each = each.value.scopes
    content {
      scope_name        = scope.value.scope_name
      scope_description = scope.value.scope_description
    }
  }
}