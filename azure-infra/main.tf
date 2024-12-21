
module "resource_group" {
  source              = "../modules/resource-group"
  resource_group_name = "my-resource-group"
  location            = "East US"
  tags = {
    environment = "dev"
    project     = "terraform-rg"
  }
}

module "vnet" {
  source              = "../modules/vnet"
  vnet_name           = "my-vnet"
  location            = "East US"
  resource_group_name = module.resource_group.resource_group_name
  address_space       = ["10.0.0.0/16"]
  tags = {
    environment = "dev"
    project     = "terraform-vnet"
  }
}


module "aks_subnets" {
  source               = "../modules/subnet"
  location             = "East US"
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.vnet.vnet_name
  subnets = [
    {
      name              = "aks-subnet"
      address_prefix    = "10.0.1.0/24"
      service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ContainerRegistry"]
    },
    {
      name              = "appgw-subnet"
      address_prefix    = "10.0.2.0/24"
      service_endpoints = ["Microsoft.Storage"]
    }
  ]
}


module "key_vault" {
  source              = "../modules/keyvault"
  key_vault_name      = "my-keyvault"
  location            = "East US"
  resource_group_name = module.resource_group.resource_group_name
  tenant_id           = "your-tenant-id"

  sku_name = "premium"

  access_policies = {
    policy1 = {
      tenant_id               = "your-tenant-id"
      object_id               = "user-or-service-principal-object-id"
      key_permissions         = ["Get", "List"]
      secret_permissions      = ["Get", "List", "Set"]
      certificate_permissions = ["Get"]
      storage_permissions     = []
    },
    policy2 = {}

  }

  tags = {
    environment = "dev"
    project     = "terraform-keyvault"
  }
}


module "log_analytics" {
  source              = "../modules/log-analytics"
  name                = "my-log-analytics"
  location            = "East US"
  resource_group_name = module.resource_group.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 90

  tags = {
    environment = "dev"
    team        = "devops"
  }

  solutions = {
    Security = {
      plan_name      = "Security"
      plan_product   = "OMSGallery/Security"
      plan_publisher = "Microsoft"
    },
    Updates = {
      plan_name      = "Updates"
      plan_product   = "OMSGallery/Updates"
      plan_publisher = "Microsoft"
    },
    ContainerInsights = {
      plan_name      = "ContainerInsights"
      plan_product   = "OMSGallery/ContainerInsights"
      plan_publisher = "Microsoft"
    },
    AzureAppGatewayAnalytics = {
      plan_name      = "AzureAppGatewayAnalytics"
      plan_product   = "OMSGallery/AzureAppGatewayAnalytics"
      plan_publisher = "Microsoft"
    }
  }
}


module "storage_account" {
  source                   = "../modules/storage-account"
  name                     = "mystorageacct001"
  resource_group_name      = "my-resource-group"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  access_tier               = "Hot"
  allow_blob_public_access  = false

  enable_network_rules       = false
  default_action             = "Deny"
  ip_rules                   = ["192.168.0.1"]
  virtual_network_subnet_ids = [module.vnet.subnet_names]
  bypass                     = ["AzureServices"]

  enable_container      = true
  container_name        = "my-container"
  container_access_type = "private"

  tags = {
    environment = "production"
    owner       = "devops-team"
  }
}


module "aks_cluster" {
  source                  = "../modules/aks"
  app_name                = "demoaks"
  resource_group          = module.resource_group.name
  aks_subnet_id           = module.aks_subnets.subnet_ids["aks-subnet"]
  applicationgw_subnet_id = module.aks_subnets.subnet_ids["appgw-subnet"]
  kubernetes_version      = "1.30.1"

  location = "East US"


  node_pools = [
    {
      name                 = "default"
      orchestrator_version = "1.25.6"
      os_disk_size_gb      = 128
      auto_scaling_enabled = true
      node_count           = 1
      min_count            = 1
      max_count            = 3
      zones                = ["1", "2", "3"]
      vm_size              = "Standard_DS2_v2"
      os_type              = "Linux"
      mode                 = "System"
      taints               = []
      tags                 = { environment = "prod" }
      subnet_name          = "aks-subnet" # Reference the correct subnet name
    }
  ]
}
