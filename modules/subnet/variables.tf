variable "location" {
  description = "The Azure location where resources will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "subnets" {
  description = "A list of subnets to create, each with a name, address_prefix, and optional service_endpoints."
  type = list(object({
    name             = string
    address_prefix   = string
    service_endpoints = optional(list(string), [])
  }))
}
