
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
  subnets = [
    {
      name             = "aks-subnet"
      address_prefixes = ["10.0.1.0/24"]
    },
    {
      name             = "appgq-subnet"
      address_prefixes = ["10.0.2.0/24"]
    }
  ]

  service_endpoints = ["Microsoft.Sql", "Microsoft.Storage"]
  
  tags = {
    environment = "dev"
    project     = "terraform-vnet"
  }
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

  enable_network_rules       = true
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
