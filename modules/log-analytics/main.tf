resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  retention_in_days   = var.retention_in_days

  tags = var.tags
}

resource "azurerm_log_analytics_solution" "solution" {
  for_each = var.solutions

  solution_name         = each.key
  resource_group_name   = var.resource_group_name
  location              = var.location
  workspace_resource_id = azurerm_log_analytics_workspace.log_analytics.id
  workspace_name        = azurerm_log_analytics_workspace.log_analytics.name

  plan {
    name      = each.value.plan_name
    product   = each.value.plan_product
    publisher = each.value.plan_publisher
  }
}