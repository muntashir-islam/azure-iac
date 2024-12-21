variable "node_pools" {
  description = "List of additional node pools configurations"
  type = list(object({
    name                 = string
    orchestrator_version = string
    os_disk_size_gb      = number
    #vnet_subnet_id       = string
    auto_scaling_enabled = bool
    node_count           = number
    min_count            = number
    max_count            = number
    zones                = list(string)
    vm_size              = string
    os_type              = string
    mode                 = string
    taints               = list(string) # List of taints in key=value:effect format
    labels               = map(string)  # Separate map for node labels
    tags                 = map(string)
  }))
  default = [
    {
      name                 = "nodepool1"
      orchestrator_version = "1.21.2"
      os_disk_size_gb      = 30
      #vnet_subnet_id       = "aks-subnet"
      auto_scaling_enabled = true
      node_count           = 3
      min_count            = 2
      max_count            = 5
      zones                = ["1", "2"]
      vm_size              = "Standard_DS2_v2"
      os_type              = "Linux"
      mode                 = "User"
      taints = [
        "key1=value1:NoSchedule", # Example taint
        "key2=value2:PreferNoSchedule"
      ]
      labels = {
        "app" = "nginx"
      }
      tags = {
        "environment" = "production"
      }
    }
  ]
}

# Variables for AKS configuration
variable "resource_group" {
  description = "Resource group name"
  type = object({
    name     = string
    location = string
  })
}

variable "app_name" {
  description = "Application name"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}


variable "tags" {
  description = "Tags for the AKS Cluster"
  type        = map(string)
  default = {
    "Environment" = "Production"
    "Project"     = "AKS Cluster"
  }
}


variable "network_plugin" {
  description = "Network Plugins"
  type        = string
  default     = "azure"

}

variable "sku_tier" {
  description = "SKU Tire"
  type        = string
  default     = "Standard"
}

variable "kubernetes_version" {
  type        = string
  description = "Version of your kubernetes node pool"
}

variable "default_pool_agents_availability_zones" {
  description = "(Optional) A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created."
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "default_pool_node_count" {
  type        = string
  description = "VM minimum amount of nodes for your node pool"
  default     = "1"
}

variable "default_nodepool_vm_size" {
  description = "VM size for the default node pool"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "aks_subnet_id" {
  description = "Subnets for K8s cluster"
  type        = string
}

variable "applicationgw_subnet_id" {
  description = "Subnets for appgw"
  type        = string
}

variable "os_disk_size_gb" {
  description = "Disk size of nodes in GBs."
  type        = number
  default     = 120
}

variable "default_labels_static" {
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool. Changing this forces a new resource to be created."
  type        = map(string)
  default = {
    Project   = "demok8s"
    node_pool = "manual"
  }
}

variable "aks_max_pod_number" {
  type    = number
  default = 30
}
