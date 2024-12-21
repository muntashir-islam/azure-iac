
variable "vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
}

variable "location" {
  description = "The location/region where the Virtual Network is created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "address_space" {
  description = "The address space for the Virtual Network"
  type        = list(string)
}

variable "subnets" {
  description = "A list of subnets to create in the Virtual Network"
  type = list(object({
    name            = string
    address_prefixes = list(string)
  }))
}

variable "tags" {
  description = "Tags to assign to the Virtual Network"
  type        = map(string)
  default     = {}
}

variable "service_endpoints" {
  description = "A list of service endpoints to associate with subnets. For example: ['Microsoft.Sql', 'Microsoft.Storage']."
  type        = list(string)
  default     = ["Microsoft.Sql", "Microsoft.Storage"]
}