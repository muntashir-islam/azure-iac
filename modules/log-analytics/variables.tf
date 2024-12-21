variable "name" {
  description = "The name of the Log Analytics workspace"
  type        = string
}

variable "location" {
  description = "The location/region where the Log Analytics workspace will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "sku" {
  description = "The SKU of the Log Analytics workspace. Possible values are 'PerGB2018', 'CapacityReservation', and 'Free'"
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "The retention period for the logs in days. Set to 0 for no retention."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags to assign to the Log Analytics workspace"
  type        = map(string)
  default     = {}
}

variable "solutions" {
  description = <<EOT
A map of solutions to deploy. Keys are solution names, and values are objects with plan configurations:
  {
    solution_name = {
      plan_name      = string
      plan_product   = string
      plan_publisher = string
    }
  }
EOT
  type = map(object({
    plan_name      = string
    plan_product   = string
    plan_publisher = string
  }))
  default = {}
}