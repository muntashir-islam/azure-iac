output "subnet_ids" {
  description = "The IDs of the created subnets."
  value       = { for k, subnet in azurerm_subnet.subnet : k => subnet.id }
}