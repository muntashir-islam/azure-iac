output "log_analytics_id" {
  value = azurerm_log_analytics_workspace.log_analytics.id
}

output "log_analytics_primary_shared_key" {
  value = azurerm_log_analytics_workspace.log_analytics.primary_shared_key
}

output "log_analytics_secondary_shared_key" {
  value = azurerm_log_analytics_workspace.log_analytics.secondary_shared_key
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.log_analytics.workspace_id
}

output "log_analytics_solution_ids" {
  value = [for key, solution in azurerm_log_analytics_solution.solution : solution.id]
}
