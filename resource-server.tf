resource "aws_cognito_resource_server" "resource_server" {
  for_each     = var.module_enabled ? { for resource in var.resource_servers : resource.identifier => resource } : {}
  identifier   = each.value.identifier
  name         = try(each.value.name, null)
  user_pool_id = aws_cognito_user_pool.user_pool[0].id

  dynamic "scope" {
    for_each = try(each.value.scopes, [])

    content {
      scope_name        = scope.value.scope_name
      scope_description = scope.value.scope_description
    }
  }
}
