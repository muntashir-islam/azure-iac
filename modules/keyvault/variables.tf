variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "location" {
  description = "The location/region where the Key Vault will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID for the Azure Active Directory"
  type        = string
}

variable "sku_name" {
  description = "The SKU name for the Key Vault. Possible values are 'standard' and 'premium'"
  type        = string
  default     = "standard"
}

variable "soft_delete_retention_days" {
  description = "Soft Delete retantion for this Key Vault"
  type        = number
  default     = 7
}

variable "purge_protection_enabled" {
  description = "Is Purge Protection enabled for this Key Vault?"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Is public network access enabled for this Key Vault?"
  type        = bool
  default     = true
}

variable "access_policies" {
  description = "A map of access policies for the Key Vault"
  type = map(object({
    tenant_id                = string
    object_id                = string
    key_permissions          = list(string)
    secret_permissions       = list(string)
    certificate_permissions  = list(string)
    storage_permissions      = list(string)
  }))
  default = {}
}

variable "tags" {
  description = "Tags to assign to the Key Vault"
  type        = map(string)
  default     = {}
}