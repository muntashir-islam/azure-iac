variable "name" {
  description = "The name of the Storage Account. Must be unique."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Storage Account."
  type        = string
}

variable "location" {
  description = "The Azure region where the Storage Account will be created."
  type        = string
}

variable "account_tier" {
  description = "The performance tier of the Storage Account. Possible values: 'Standard', 'Premium'."
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "The replication strategy for the Storage Account. Possible values: 'LRS', 'GRS', 'RAGRS', 'ZRS'."
  type        = string
  default     = "LRS"
}

variable "enable_https_traffic_only" {
  description = "Enforce HTTPS for accessing the Storage Account."
  type        = bool
  default     = true
}

variable "min_tls_version" {
  description = "The minimum TLS version for requests to the Storage Account."
  type        = string
  default     = "TLS1_2"
}

variable "access_tier" {
  description = "The access tier for Blob Storage. Possible values: 'Hot', 'Cool'."
  type        = string
  default     = "Hot"
}

variable "allow_blob_public_access" {
  description = "Allow or disallow public access to blobs."
  type        = bool
  default     = false
}

variable "enable_network_rules" {
  description = "Enable network rules for the storage account."
  type        = bool
  default     = false
}

variable "default_action" {
  description = "Default action for network rules. Possible values: 'Allow', 'Deny'."
  type        = string
  default     = "Deny"
}

variable "ip_rules" {
  description = "List of public IP addresses or ranges to allow."
  type        = list(string)
  default     = []
}

variable "virtual_network_subnet_ids" {
  description = "List of virtual network subnet IDs to allow."
  type        = list(string)
  default     = []
}

variable "bypass" {
  description = "Services that bypass network rules. Possible values: 'None', 'Logging', 'Metrics', 'AzureServices'."
  type        = list(string)
  default     = ["AzureServices"]
}

variable "enable_container" {
  description = "Enable the creation of a storage container."
  type        = bool
  default     = false
}

variable "container_name" {
  description = "The name of the storage container."
  type        = string
  default     = "default-container"
}

variable "container_access_type" {
  description = "The level of public access to the container. Possible values: 'blob', 'container', 'private'."
  type        = string
  default     = "private"
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}