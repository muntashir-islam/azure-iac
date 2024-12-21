output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "storage_account_id" {
  value = azurerm_storage_account.storage.id
}

output "primary_blob_endpoint" {
  value = azurerm_storage_account.storage.primary_blob_endpoint
}

output "primary_queue_endpoint" {
  value = azurerm_storage_account.storage.primary_queue_endpoint
}

output "primary_file_endpoint" {
  value = azurerm_storage_account.storage.primary_file_endpoint
}