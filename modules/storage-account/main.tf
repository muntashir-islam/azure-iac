resource "azurerm_storage_account" "storage" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  https_traffic_only_enabled    = var.enable_https_traffic_only
  min_tls_version               = var.min_tls_version
  access_tier                   = var.access_tier
  public_network_access_enabled = var.allow_blob_public_access

  tags = var.tags
}


resource "azurerm_storage_account_network_rules" "network_rules" {
  count = var.enable_network_rules ? 1 : 0

  storage_account_id = azurerm_storage_account.storage.id

  default_action             = var.default_action
  ip_rules                   = var.ip_rules
  virtual_network_subnet_ids = var.virtual_network_subnet_ids
  bypass                     = var.bypass
}

resource "azurerm_storage_container" "container" {
  count                  = var.enable_container ? 1 : 0
  name                   = var.container_name
  storage_account_id   = azurerm_storage_account.storage.id
  container_access_type  = var.container_access_type
}