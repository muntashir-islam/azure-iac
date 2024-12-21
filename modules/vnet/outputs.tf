output "vnet_name" {
  description = "The name of the Virtual Network"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_address_space" {
  description = "The address space of the Virtual Network"
  value       = azurerm_virtual_network.vnet.address_space
}

output "subnet_names" {
  description = "The names of the subnets in the Virtual Network"
  value       = [for subnet in azurerm_subnet.subnets : subnet.name]
}