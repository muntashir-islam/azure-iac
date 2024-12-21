output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "resource_group_location" {
  description = "The location of the resource group"
  value       = azurerm_resource_group.rg.location
}

output "resource_group_tags" {
  description = "The tags assigned to the resource group"
  value       = azurerm_resource_group.rg.tags
}